# Project Title: Fully Dispersed Haar-like Filters for Face Detection

## Description
This repository contains the MATLAB code and datasets for implementing the **Fully Dispersed Haar-like Filter** for feature extraction of face images. The goal of this project is to provide a Fully Dispersed Haar-like Filter for feature extraction, as proposed by **Z. Sedaghtjoo, H. Hosseinzadeh, and A. Shirzadi**.

Haar-like filters are renowned for their simplicity, speed, and accuracy in various computer vision tasks [6].
Haar-like features are local texture descriptors that quantify differences in the average intensity values between adjacent rectangular regions [9, 10]. Figure 1 illustrates several simple Haar-like filters that
are commonly employed in feature extraction applications. 

![Example of Results](images/Haar_like_F2.jpg)

As illustrated in Figure 1, Haar-like filters are commonly represented as combinations of two or more rectangular regions composed of black and white pixels [6]. 
This figure showcases various examples of Haar-like filters, with the default weights clearly indicated on their respective rectangles.
The feature value g for a Haar-like filter is defined as follows:
g(x) = v1 m1(x) + v2 m2(x), (1.1)
where x is an image, and m1 and m2 denote the mean intensities of the pixels within
the black and white regions of the filter, respectively. The weights v1 and v2 correspond
to these regions and are typically represented as two integers whose sum equals zero.
Numerous algorithms are available for determining the optimal values of weights, including brute-force search (BFS) [6], genetic algorithms (GA) [12, 13], and Fisher’s linear
discriminant analysis (FLDA) [14]. This paper focuses specifically on identifying optimal Haar-like filters characterized by equal black and white regions. In this context, the
weights are assigned as v1 = −1 and v2 = 1.
A novel code is proposed here to identify optimal fully dispersed Haar-like filters for enhanced facial feature extraction and recognition. Unlike traditional Haar-like filters, these novel filters allow pixels to move freely within images, enabling more effective capture of intricate local features.
Through extensive experiments on face detection, we demonstrate in \cite{} that our optimized filters can distinguish between face images
and clutter with minimal error, outperforming existing code. 

## Contents
- **MATLAB Code**: The main algorithm implemented in MATLAB for feature Extraction of face images process.
- **Datasets**: Two data files containing the clutter and face images used in this project.
  - `Clutter2.mat`: Contains clutter data for training and testing.
  - `Pics.mat`: Contains face images for training and testing.

## Installation
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter.git

   ```

2. Ensure you have MATLAB installed to run the code. The required version is **MATLAB R2020b** or newer.

## Usage
1. Open the MATLAB script **Fully_Dispered_HaarLike.m**.
2. Load the dataset files by running:
   ```matlab
   load('Clutter2.mat');
   load('Pics.mat');
   ```
3. Run the script to start feature Extraction process..
4. View the results in the MATLAB workspace.

## Contribution Guidelines
We welcome contributions to improve the algorithm, code, or documentation. If you'd like to contribute, please:
1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Make your changes and test them.
4. Create a pull request with a detailed description of your changes.


## Citation
If you use this code or dataset in your research, please cite this repository in your work:
```
Sedaghatjoo, S. (2024). Fully Dispersed Haar-like Filter for Face Detection. GitHub Repository. https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter
```

## Links
- **Dataset**: [Clutter2.mat](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD/blob/master/Clutter2.mat) and [Pics.mat](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD/blob/master/Pics.mat)
- **GitHub Repository**: [https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD)








