# Copyright (C) 2022 Daniel Enériz and Antonio Rodriguez
# 
# This file is part of UZ-ULPGC-Physionet2022.
# 
# UZ-ULPGC-Physionet2022 is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# UZ-ULPGC-Physionet2022 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with UZ-ULPGC-Physionet2022.  If not, see <http://www.gnu.org/licenses/>.

import numpy as np
from typing import Tuple, Dict
import scipy.signal
import pywt
import warnings
from utils import load_recordings, schmidt_spike_removal
from helper_code import load_patient_data
from tensorflow.keras.utils import to_categorical
from tqdm import tqdm

# Filter the BadCoefficients warning
warnings.filterwarnings('ignore', category=scipy.signal.BadCoefficients)

# Define the function to compute the Homomorphic Envelope and the Hilbert envelope:
def homomorphic_envelogram_with_hilbert(input_signal: np.ndarray, fs: float, lpf_frequency=8) -> Tuple[np.ndarray, np.ndarray]:
    """Calculate the homomorphic envelope of a signal based on the Hilbert's
    envelope, which is also returned. This implementation is based on Mutasem
    Aldmour's work https://github.com/mutdmour/mlnd_heartsound which is a
    reimplementation of the MATLAB version published by David Springer
    https://github.com/davidspringer/Schmidt-Segmentation-Code.

    In [1-3], the researchers found the homomorphic envelope of Shannon energy.
    However, in [4], the authors state that the singularity at 0 when using the
    natural logarithm (resulting in values of -inf) can be fixed by using a
    complex valued signal. They motivate the use of the Hilbert transform to
    find the analytic signal, which is a converstion of a real-valued signal to
    a complex-valued signal, which is unaffected by the singularity.

    The usage of the Hilbert transform is explained in [5].

    Args:
    -----
        input_signal: 1D numpy array containing the input signal.
        fs: Sampling frequency of the input signal.
        lpf_frequency: Cutoff frequency of the low-pass filter. Default is 8 Hz.

    Returns:
    --------
        hilbert_envelope: 1D numpy array containing the Hilbert envelope.
        homomorphic_envelope: 1D numpy array containing the homomorphic envelope
        of the input signal.

    References:
    -----------
        [1] S. E. Schmidt et al., Segmentation of heart sound recordings by a 
        duration-dependent hidden Markov model., Physiol. Meas., vol. 31, no. 4,
        pp. 513?29, Apr. 2010.
        
        [2] C. Gupta et al., Neural network classification of homomorphic segmented
        heart sounds, Appl. Soft Comput., vol. 7, no. 1, pp. 286-297, Jan. 2007.
        
        [3] D. Gill et al., Detection and identification of heart sounds using 
        homomorphic envelogram and self-organizing probabilistic model, in 
        Computers in Cardiology, 2005, pp. 957-960.

        [4] I. Rezek and S. Roberts, Envelope Extraction via Complex Homomorphic
        Filtering. Technical Report TR-98-9, London, 1998

        [5] Choi et al, Comparison of envelope extraction algorithms for cardiac
        sound signal segmentation, Expert Systems with Applications, 2008.
    """
    # Check if the input signal is a 1D numpy array:
    if not isinstance(input_signal, np.ndarray) or len(input_signal.shape) != 1:
        raise ValueError('The input signal must be a 1D numpy array.')

	#8Hz, 1st order, Butterworth LPF
    B_low, A_low  = scipy.signal.butter(1,2*lpf_frequency/fs,'low')

    # Obtain the Hilbert transform:
    hilbert_envelope = np.abs(scipy.signal.hilbert(input_signal))

    # Calculate the homomorphic envelope of the signal using the Hilbert transform to obtain the analytic signal.
    homomorphic_envelope = np.exp(scipy.signal.filtfilt(B_low, A_low, np.log(hilbert_envelope)))

    return hilbert_envelope, homomorphic_envelope

# Define the function to compute the PSD envelope:
def psd(input_signal: np.ndarray, fs: float, fl_low: float = 40, fl_high: float = 60, resample: bool = True) -> np.ndarray:
    """Calculate the PSD envelope of a signal between fl_low and fl_high. This
    implementation is based on the description available at [1].
    
    Args:
    -----
        input_signal: 1D numpy array containing the input signal.
        fs: Sampling frequency of the input signal
        fl_low: Lower frequency limit of the PSD envelope. Defaults to 40 Hz.
        fl_high: Higher frequency limit of the PSD envelope. Defaults to 60 Hz.
        resample: If True, the signal is resampled to fs. Defaults to True.

    Returns:
    --------
        psd_envelope: 1D numpy array containing the PSD envelope of the input
        signal.

    References:
    -----------
        [1] D. Springer et al., "Logistic Regression-HSMM-based Heart Sound
        Segmentation," IEEE Trans. Biomed. Eng., In Press, 2015.
    """

    # * It reduces significantly the equivalent sampling frecuency 

    # Check if the input is a 1D numpy array
    if not isinstance(input_signal, np.ndarray) or len(input_signal.shape) != 1:
        raise ValueError('The input signal must be a 1D numpy array.')

    # Check if frecuecy limits are valid
    if fl_low < 0 or fl_low > fs/2:
        raise ValueError('The lower frequency limit must be between 0 and fs/2.')
    if fl_high < 0 or fl_high > fs/2:
        raise ValueError('The higher frequency limit must be between 0 and fs/2.')
    if fl_low > fl_high:
        raise ValueError('The lower frequency limit must be smaller than the higher frequency limit.')
    
    # Find the spectrogram of the signal. The window width is set to 0.05
    # seconds, with 50% overlap.
    f, t, Sxx = scipy.signal.spectrogram(input_signal, fs, nperseg=int(fs*0.5*0.05), noverlap=int(fs*0.05*0.5*0.5), nfft=int(fs))

    # Find the lower and higher frequency limits of the PSD envelope
    fl_low_index = np.argmin(np.abs(f-fl_low))
    fl_high_index = np.argmin(np.abs(f-fl_high))

    # Find the mean PSD over the frequency range
    psd_envelope = np.mean(Sxx[fl_low_index:fl_high_index,:], axis=0)

    if resample:
        # Resample the PSD envelope to the input signal's sampling frequency
        psd_envelope = scipy.signal.resample(psd_envelope, len(input_signal))

    return psd_envelope

# Partially extracted from: https://github.com/cmescobar/Heart_sound_prediction/blob/master/hsp_utils/envelope_functions.py
def wavelet(signal_in, wavelet='db1', levels=[4],
            start_level=1, end_level=5, erase_pad=True)-> np.ndarray:
    """Calculates and returns the Wavelet envelope of a signal based on  Shannon's 
    energy [1,2]. This implementation is based on Christian Escobar Arcer's work 
    https://github.com/cmescobar/Heart_sound_prediction. He used the Stationary Wavelet
    Decomposition, that corresponds to the Discrete Wavelet Transform without 
    decimating the signal. 

    In [3], the researches used a similar method to produce one of the four different 
    envelopes that would be the input of a segmentation Convolutional Neural Network 
    (CNN).

    Args:
    -----
    signal_in: 1D numpy array containing the input signal.
    wavelet: used wavelet (https://www.pybytes.com/pywavelets/ref/wavelets.html)
    levels: selected levels for 
    start_level: Wavelet decomposition start level
    end_level: Wavelet decomposition end level
    erase_pad: boolean that indicates is padding to compute the 
                Stationary Wavelet Transform is erased or not 

    Returns:
    --------
    DWT_envs: n-D numpy array containing the Shannon envelope for the selected
    Wavelet decomposition levels (i.e., "levels" values).

    References:
    -----------

    [1] L. Huiying et al., A Heart Sound Segmentation Algorithm using Wavelet 
    Decomposition and Reconstruction, 19th International Conference - 
    IEEE/EMBS, 1997. 

    [2] Choi et al, Comparison of envelope extraction algorithms for cardiac
    sound signal segmentation, Expert Systems with Applications, 2008.

    [3] Renna et al., Deep Convolutional Neural Network for Heart Sound Segmentation,
    IEEE Journal of Biomedical and Health Informatics, 2019.
    """  
    # Original data points number
    N = signal_in.shape[0]

    # Amount of desired points 
    points_desired = 2 ** int(np.ceil(np.log2(N)))

    # Padding points number definition 
    pad_points = (points_desired-N) // 2

    # Padding to reach the needed power of two Paddeando 
    audio_pad = np.pad(signal_in, pad_width=pad_points,
                        constant_values=0)

    # Stationary Wavelet Decomposition
    coeffs = pywt.swt(audio_pad, wavelet=wavelet, level=end_level, 
                      start_level=start_level)

    # Array to store decomposition levels 
    wav_coeffs = np.zeros((len(coeffs[0][1]), 0))

    for level in levels:
        # Indexes according to pywt.swt(.) output
        coef_i =  np.expand_dims(coeffs[-level + start_level][1], -1)
        
        # Coefficients concatenation
        wav_coeffs = np.concatenate((wav_coeffs, coef_i), axis=1)
        
    # Erase padding points if needed.
    # The pad_points is added to skip pad_points = 0 cases
    if erase_pad and pad_points:
        wav_coeffs_out = wav_coeffs[pad_points:-pad_points]
    else:
        wav_coeffs_out = wav_coeffs
    
    # Normalization of decomposition coefficients
    coeffs_norm = wav_coeffs_out/np.max(wav_coeffs_out)

    # Substitute zero values with an small number to avoid log(0)
    coeffs_norm[coeffs_norm == 0] = 1e-10
    
    # Computation of Shannon Energy 
    DWT_envs = -(np.square(coeffs_norm)*np.log(np.square(coeffs_norm)))

    # Supress second dimension of array 
    DWT_envs = DWT_envs[:, 0]

    return np.abs(DWT_envs)

default_envelope_config = {
    'homomorphic_envelogram_with_hilbert': {'lpf_frequency': 8},
    'psd': {'fl_low': 40, 'fl_high': 60, 'resample': True},
    'wavelet': {'wavelet': 'db1',
                'levels': [4],
                'start_level': 1,
                'end_level': 5,
                'erase_pad': True}
}

def get_envelopes(input_signal: np.ndarray, fs: float,
    config_dict: Dict = default_envelope_config) -> np.ndarray:
    """Gets the envelopes and evelograms from the input signal, using the
    parameters defined in config_dict.
    
    Args:
    -----
        input_signal (np.ndarray): 1D numpy array containing the input signal.
        fs (float): Sampling frequency of the input signal.
        config_dict (Dict): Dictionary with the configuration of the
        envelopes.
    
    Returns:
    --------
        x (np.ndarray): Stack of the selected the envelopes/envelograms. The
        default order is homomorphic, hilbert, psd, and wavelet.
    """

    # Check if the input is a 1D numpy array
    if not isinstance(input_signal, np.ndarray) or len(input_signal.shape) != 1:
        raise ValueError('The input signal must be a 1D numpy array.')

    # Check if the dictionary is valid
    if not isinstance(config_dict, dict):
        raise ValueError('The config_dict must be a dictionary.')

    # Get the envelopes
    envelopes = []
    for key, value in config_dict.items():
        if key == 'homomorphic_envelogram_with_hilbert':
            hilbert_envelope, homomorphic_envelope = homomorphic_envelogram_with_hilbert(input_signal, fs, config_dict[key]['lpf_frequency'])
            envelopes.append(homomorphic_envelope)
            envelopes.append(hilbert_envelope)
        elif key == 'psd':
            psd_envelope = psd(input_signal, fs, config_dict[key]['fl_low'], config_dict[key]['fl_high'], config_dict[key]['resample'])
            envelopes.append(psd_envelope)
        elif key == 'wavelet':
            wavelet_envelope = wavelet(input_signal, config_dict[key]['wavelet'], config_dict[key]['levels'], config_dict[key]['start_level'],config_dict[key]['end_level'],config_dict[key]['erase_pad'])
            envelopes.append(wavelet_envelope)

    # Stack the envelopes
    x = np.stack(envelopes, axis=0)

    return x

def renna_preprocess_wave(input_signal: np.ndarray, fs: float,
                     config_dict: Dict = default_envelope_config) -> np.ndarray:
    """This function preprocess the data as described in [1]. First a bandpass
    filter is applied to the signal between 25 and 400Hz. Then the spike removal
    method described in [2] is used, which is followed by the envelogram
    generation used in [3]. After this, the envelograms are downsampled to 50 Hz.
    Finally, a standardization (normalization with mean 0 and deviation 1) is used.

    Args:
    -----
        input_signal (np.ndarray): The data to be preprocessed.
        fs (float): Sampling frecuency of the signal.
        config_dict (Dict): Configuration dictionary for the envelopes
        generation.
    
    Returns:
    --------
        x, an np.ndarray containing the envelograms, with shape (4, 50*T), where
        T is the duration of input_signal.

    References:
    -----------
        [1] Renna, F., Oliveira, J., & Coimbra, M. T. (2019). Deep Convolutional
        Neural Networks for Heart Sound Segmentation. IEEE journal of biomedical
        and health informatics, 23(6), 2435-2445.
        https://doi.org/10.1109/JBHI.2019.2894222

        [2] S. E. Schmidt et al., "Segmentation of heart sound recordings by 
        a duration-dependent hidden Markov model," Physiol. Meas., vol. 31, no.
        4, pp. 513-29, Apr. 2010

        [3] D. Springer et al., "Logistic Regression-HSMM-based Heart Sound
        Segmentation," IEEE Trans. Biomed. Eng., In Press, 2015.
    """

    # Check if the input is a 1D numpy array
    if not isinstance(input_signal, np.ndarray) or len(input_signal.shape) != 1:
        raise ValueError('The input signal must be a 1D numpy array.')
    
    # Desing a BP filter between 25 and 400 Hz.
    filter = scipy.signal.butter(4, [25, 400], btype='bandpass', fs=fs, output='sos')
    # Apply the filter
    data = scipy.signal.sosfilt(filter, input_signal)

    # Spike removal from Schmidt et al. 2010 https://pubmed.ncbi.nlm.nih.gov/20208091/
    data = schmidt_spike_removal(data, fs)

    # Generate the envelograms
    x = get_envelopes(data, fs, config_dict)

    # Downsample the envelograms to 50 Hz. 
    x = scipy.signal.decimate(x, int(fs/50))

    # Standardize the envelograms
    #x = (x - x.mean(axis=1, keepdims=True)) / x.std(axis=1, keepdims=True)

    return x

def renna_preprocess_circor_annotations(input_data: np.ndarray) -> np.ndarray:
    """Takes the raw read annotations from the .tsv file of the CirCor dataset
    [1] and generates the s array, containing the labels of the heart states at
    50 Hz. Note that here s(t) is in the range (0 - 4), where 0 is the
    unclassified label and the values 1 to 4 represent each heart state.

    Args:
    -----
        input_data (np.ndarray): The raw annotations from the .tsv file.
    
    Returns:
    --------
        s (np.ndarray): The heart states at 50 Hz.
    
    References:
    -----------
        [1] J. H. Oliveira et al., "The CirCor DigiScope Dataset: From Murmur
        Detection to Murmur Classification," in IEEE Journal of Biomedical and
        Health Informatics, doi: 10.1109/JBHI.2021.3137048.
    """
    # Check if the input is a 2D numpy array with the second dimension of size 3
    if not isinstance(input_data, np.ndarray) or len(input_data.shape) != 2 or input_data.shape[1] != 3:
        raise ValueError('The input data must be a 2D numpy array with the second dimension of size 3.')

    # Find the duration in seconds of the recording (last value of the second column)
    T = input_data[-1,1]
    
    # Generate a time array with 50 Hz sampling rate
    t = np.arange(0, T, 1.0/50.0)

    # Generate the s array
    s = np.zeros_like(t)

    # For each time instant, find its heart state and assign it to the s array
    for i in range(len(t)):
        # Find the first value greater than t(i)
        j = np.argmax(input_data[:,1] > t[i])
        # Assign the heart state to s(i)
        s[i] = input_data[j,2]

    return s

def rolling_strided_window(x: np.ndarray, N: int, tau: int) -> np.ndarray:
    """Takes the input 2D array and extracts windows of size N and stride tau
    along de second dimension. If the input array is 1D another dimesion is
    expanded to perform de operation.

    Args:
    -----
        x (np.ndarray): Input 2D array.
        N (int): Size of the windows.
        tau (int): Stride of the windows.

    Returns:
    --------
        x_windows (np.ndarray): 2D array with the windows.
    """

    orig_input_1D = False

    # Check if the input is 1D
    if x.ndim == 1:
        x = x[np.newaxis, :]
        orig_input_1D = True
    
    # Check if the input is 2D
    if x.ndim != 2:
        raise ValueError("The input array must be 2D or 1D to be expanded.")

    # Check if the stride is a positive integer
    if not isinstance(tau, int) or tau <= 0:
        raise ValueError("The stride must be a positive integer.")
    
    # Check if the window size is a positive integer
    if not isinstance(N, int) or N <= 0:
        raise ValueError("The window size must be a positive integer.")
    
    x_windows = np.lib.stride_tricks.sliding_window_view(x, (x.shape[0],N))[:, 0::tau]

    # Remove the first dimension since it always outputs a 4D if the input is 2D
    x_windows = x_windows[0,:,:,:]

    # If the input was 1D, remove the extra dimension added at the beginning
    if orig_input_1D:
        x_windows = x_windows[:,0,:]

    return x_windows
   
def check_valid_sequence(x: np.ndarray, s: np.ndarray, verbose: int) -> Tuple[np.ndarray, np.ndarray]:
    """As there are annotations that have illegal heart state transitions, as
    the first 3 -> 1 in the 500086_MV.tsv file, this function checks if the
    heart state sequence of each window in s is valid, removing the windows
    that are not. Also it removes the windows with less than 3 heart
    transitions.

    Args:
    -----
        x (np.ndarray): The signal of the recording.
        s (np.ndarray): The heart state sequence of the recording.
        verbose (int): Verbosity level.

    Returns:
    --------
        x_valid (np.ndarray): The signal of the recording with only the valid
        windows.
        s_valid (np.ndarray): The heart state sequence of the recording with
        only the valid windows.
    """

    # Check if the first dimension is the same in x and s
    if x.shape[0] != s.shape[0]:
        raise ValueError('The first dimension of x and s must be the same.')
    
    # Iterate over the windows
    invalid_idxs = []
    for i in range(s.shape[0]):
        # Check if the heart state sequence is valid
        if np.unique(s[i, :]).shape[0] < 4:
            invalid_idxs.append(i)
            if verbose >= 2:
                warnings.warn('Window {} has less than 3 heart transitions'.format(i), RuntimeWarning)
        else:
            for j in range(1, s.shape[1]):
                if not (s[i, j] == s[i, j-1] or s[i, j] == s[i, j-1] % 4 + 1):
                    invalid_idxs.append(i)
                    if verbose >= 2:
                        warnings.warn('Invalid transition from {} to {} in window {}.'.format(s[i, j-1], s[i, j], i), RuntimeWarning)
                    break
        
    
    # Remove the invalid windows
    x_valid = np.delete(x, invalid_idxs, axis=0)
    s_valid = np.delete(s, invalid_idxs, axis=0)

    return x_valid, s_valid

def generate_preproc_tb(filenames: list, data_folder: str, N: int, verbose: int) -> Tuple[np.ndarray, np.ndarray]:
    """Generates the X and S arrays for the CirCor dataset [1]. The X array
    contains windows of size N and stride tau of the envelograms of the
    recordings sampled at 50 Hz, as done in Renna et al. [2]. The S array
    contains the heart state sequence of the recordings.

    Args:
    -----
        filenames (list): List of strings with the filenames of patient data
        (`.txt` files).
        data_folder (str): Path to the folder containing the data.
        N (int): Size of the windows.
        tau (int): Stride of the windows.
        verbose (int): Verbosity level.
    
    Returns:
    --------
        X (np.ndarray): 3D array with the windows of the recordings. Its shape
        is (number of windows, N, number of envelograms).
        S (np.ndarray): 3D array with the heart state sequence of the
        recordings. Its shape is (number of windows, N, number of heart states).
    """

    counter = 0
    
    # Generate an XS vector from x and s with length N and stride tau
    # Initialize the X and S arrays
    X_in = np.zeros((N*80))
    X_out = np.zeros((4, N))

    # Extract all recording for each patient
    for name in tqdm(filenames, desc='Iterating over patients') if verbose >=1 else filenames:

        if name.endswith('50782.txt'):
            # Discard this patient since there isn't a 50782_MV_1.tsv file and
            # 50782_MV.tsv (which is supposed to be 50782_MV_1.tsv) has no
            # annotations.
            continue
        
        data = load_patient_data(name)

        for recording, filename in load_recordings(data_folder, data, get_filenames=True):

            counter = counter+1

            if counter > 18:
                break
            else:

                # Get envelopes and store original signal
                x_in = recording
                x_out = renna_preprocess_wave(recording, fs = 4000)

                for k in range(0, len(x_in), N*80):

                    if k + N*80 > len(x_in):
                        # If the window is smaller than N, discard it
                        continue
                    
                    else: 
                    
                        input = x_in[k:k+(N*80)]
                        output = x_out[:, round(k/80):round(k/80)+N]

                        X_in = np.vstack((X_in, input))
                        X_out = np.dstack((X_out, output))   
    print("Test input shape: ", X_in.shape)
    print("Test output shape: ", X_out.shape)
    print("Test bench total samples: ", X_in.shape[0])  

    # Remove the first row of zeros
    X_in = X_in[1:,:]
    X_out = X_out[:,:,1:]

    # Iterate over the X_in rows to save it in a .txt file
    for i in range(X_in.shape[0]): 
        # Save the X_in and X_out arrays as .txt
        np.savetxt(r"X_in_{}.txt".format(i), X_in[i], fmt='%1.10f')
        np.savetxt(r"X_out_{}.txt".format(i), X_out[:,:,i], fmt='%1.10f')

        # np.save(r"..\X_in_{}.npy".format(i), X_in[i])
        # np.save(r"..\X_out_{}.npy".format(i), X_out[:,:,i])

    print("\nHLS testbench files succesfully saved as .txt!")    

    return X_in, X_out