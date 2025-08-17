# Phonocardiogram Pre-processing module for FPGA-based designs
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![GitHub issues](https://img.shields.io/github/issues/domenico-rgs/PCG-envelograms-on-FPGA)](https://github.com/domenico-rgs/PCG-envelograms-on-FPGA/issues)
[![GitHub stars](https://img.shields.io/github/stars/domenico-rgs/PCG-envelograms-on-FPGA)](https://github.com/domenico-rgs/PCG-envelograms-on-FPGA/stargazers)

This is an FPGA design for extracting four different envelograms from phonocardiogram (PCG) recordings.
The envelograms are the Power Spectral Density (PSD) envelope, the Hilbert envelope, the Wavelet envelope and the Homomorphic envelogram.
More details can be found in this paper that uses such features for segmenting PCGs: [Deep Convolutional Neural Networks for Heart Sound Segmentation - IEEE Journal of Biomedical and Health Informatics](https://ieeexplore.ieee.org/abstract/document/8620278)

**Table of Contents**
- [Phonocardiogram Pre-processing module for FPGA-based designs](#phonocardiogram-pre-processing-module-for-fpga-based-designs)
  - [Requirements and Project Structure](#requirements-and-project-structure)
  - [Results](#results)
    - [Citation](#citation)

## Requirements and Project Structure
This project requires **Vivado 2023.2** and **Vitis Model Composer**.  
The code is organized in the `src/` directory, which contains the Matlab/VMC designs of the modules for recorded inputs quantized at 16 or 32 bits, the required variables, the corresponding `.m` files, and two Python notebooks used for output analysis.

## Results
:dart: All the results obtained from the tests are explained in the following paper: [FPGA Design of Digital Circuits for Phonocardiogram Pre-Processing Enabling Real-Time and Low-Power AI Processing](https://www.doi.org/10.1109/dsd64264.2024.00084).

### Citation
```bibtex
@INPROCEEDINGS{10741821,
  author={Ragusa, Domenico and Rodriguez-Almeida, Antonio J. and Gazzoni, Marco and Torti, Emanuele and Marenzi, Elisa and Fabelo, Himar and Callico, Gustavo M. and Leporati, Francesco},
  booktitle={2024 27th Euromicro Conference on Digital System Design (DSD)}, 
  title={FPGA Design of Digital Circuits for Phonocardiogram Pre-Processing Enabling Real-Time and Low-Power AI Processing}, 
  year={2024},
  volume={},
  number={},
  pages={588-595},
  keywords={Point of care;Signal processing algorithms;Transforms;Standardization;Real-time systems;Topology;Convolutional neural networks;Artificial intelligence;Phonocardiography;Digital circuits;Cardiovascular diseases;FPGA;Digital signal processing;Point-of-care;Medical device;Pre-processing;Phonocardiogram;Artificial intelligence},
  doi={10.1109/DSD64264.2024.00084}
  }