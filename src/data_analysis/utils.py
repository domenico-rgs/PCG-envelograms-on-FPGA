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
import librosa
from typing import Tuple
import os
from helper_code import get_num_locations
import tensorflow as tf

# Define the spike removal function
def schmidt_spike_removal(original_data: np.ndarray, fs: float) -> np.ndarray:
    """This function removes the spikes from the data as described in [1]. It is
    based on the MATLAB implementation of David Springer
    (https://github.com/davidspringer/Schmidt-Segmentation-Code/blob/master/schmidt_spike_removal.m)
    and the Python implementation of Mutasem Aldmour
    (https://github.com/mutdmour/mlnd_heartsound/blob/master/project/sampleModel/schmidt_spike_removal.py)
    
    Args:
    -----
        data (np.ndarray): The data to be preprocessed.
        fs (float): The sampling frequency of the data.
    
    Returns:
    --------
        np.ndarray: The preprocessed data.
    
    References:
    -----------
        [1] S. E. Schmidt et al., "Segmentation of heart sound recordings by a
        duration-dependent hidden Markov model," Physiol. Meas., vol. 31, no. 4,
        pp. 513-29, Apr. 2010
    """
    # Find the window size to be 500ms
    window_size = int(np.round(fs*0.5))

    # Find any samples outside of a integer number of windows
    trailing_samples = int(np.mod(original_data.size, window_size))

    # Reshape the singal into a number of windows
    #sample_frames = original_data[:original_data.size-trailing_samples].reshape(window_size, -1)
    sample_frames = np.array(np.split(original_data[:original_data.size-trailing_samples], round((original_data.size-trailing_samples)/window_size), axis=0))
    
    # Find the MAAs (Maximum Absolute Amplitude) of each window
    maa = np.max(np.abs(sample_frames), axis=1)

    # While there are still samples greater than 3* the median value of the MAAs,
    # then remove those spikes
    while np.any(maa > 3*np.median(maa)):
        
        # Find the window with the maximum MAAs
        window_num = np.argmax(maa)

        # Find the position of the spike within that window
        spike_idx = np.argmax(np.abs(sample_frames[window_num, :]))

        # Finding zero crossings (where there may not be actual 0 values, just
        # a change from positive to negative or vice versa)):
        zero_crossings = np.abs(np.diff(np.sign(sample_frames[window_num][:])))
        if (len(zero_crossings) == 0):
            zero_crossings = [0]
        zero_crossings = [1 if i > 1 else 0 for i in zero_crossings ] + [0]

        #Find the start of the spike, finding the last zero crossing before
        # spike position. If that is empty, take the start of the window:
        spike_start = np.nonzero(zero_crossings[0:spike_idx+1])[0]
        # print spike_start
        if (len(spike_start) > 0):
            spike_start = spike_start[-1]
        else:
            spike_start = 0

        # Find the end of the spike, finding the first zero crossing after spike
        # position. If that is empty, take the end of the window:
        zero_crossings[0:spike_idx+1] = [0]*(spike_idx+1)
        spike_end = np.nonzero(zero_crossings)[0]
        if (len(spike_end) > 0):
            spike_end = spike_end[0] + 1
        else:
            spike_end = window_size

        # Set to zero the samples within the spike
        sample_frames[window_num, spike_start:spike_end] = 0.0001

        # Recalculate the MAAs
        maa = np.max(np.abs(sample_frames), axis=1)
    
    # Reshape the signal back into a single vector
    data = sample_frames.reshape(-1)

    # Add the trailing samples back to the signal
    if trailing_samples:
        data = np.append(data, original_data[-trailing_samples:])

    return data

def load_recordings(data_folder: str, data: str, get_frequencies: bool = False,
                    get_filenames: bool = False):
    """This function loads the recordings from the patient included in `data`.
    It is based on (a function of the PhysioNet Challenge 2022 example
    code)[https://github.com/physionetchallenges/python-classifier-2022/blob/edf2c64cdbc8d467ac69253d31ff76243c96e041/helper_code.py#L66]
    but adapted to use librosa to read the wavs and to optionally output the
    filenames.

    Args:
    -----
        data_folder (str): The folder where the data is stored.
        data (str): The patient data. This must be loaded using `helper_code.load_patient_data`.
        get_frequencies (bool): Whether to output the frequencies of the recordings.
        get_filenames (bool): Whether to output the filenames of the recordings.
    
    Returns:
    --------
        A tuple containing these elements zipped:
            Tuple of np.ndarray: The recordings.
            Tuple of sampling frequencies. (Optional)
            Tuple of filenames. (Optional)
    """
    num_locations = get_num_locations(data)
    recording_information = data.split('\n')[1:num_locations+1]

    recordings = list()
    frequencies = list()
    filenames = list()
    for i in range(num_locations):
        entries = recording_information[i].split(' ')
        recording_file = entries[2]
        filename = os.path.join(data_folder, recording_file)
        recording, frequency = librosa.load(filename, sr=None)

        # If the recording lentgh is odd, remove the last sample
        if len(recording) % 2 == 1:
            recording = recording[:-1]

        recordings.append(recording)
        frequencies.append(frequency)
        filenames.append(filename)

    if get_frequencies:
        if get_filenames:
            return zip(recordings, frequencies, filenames)
        else:
            return zip(recordings, frequencies)
    else:
        if get_filenames:
            return zip(recordings, filenames)
        else:
            return recordings

def set_memory_growth():
    """This function sets the memory growth of the current process to True.
    This is necessary to use the GPU.
    """
    physical_devices = tf.config.list_physical_devices('GPU')

    for gpu in physical_devices:
        try:
            tf.config.experimental.set_memory_growth(gpu, True)
        except:
            # Invalid device or cannot modify virtual devices once initialized.
            pass