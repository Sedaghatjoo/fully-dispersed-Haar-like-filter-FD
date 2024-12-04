# Project Title: Fully Dispersed Haar-like Filters for Face Detection

## Description
This repository contains the MATLAB code and datasets for implementing the **Fully Dispersed Haar-like Filter** for feature extraction of face images. The goal of this project is to provide a Fully Dispersed Haar-like Filter for feature extraction, as proposed by **Z. Sedaghtjoo, H. Hosseinzadeh, and A. Shirzadi** in [[1]]. 

Haar-like filters are renowned for their simplicity, speed, and accuracy in various computer vision tasks.
Haar-like features are local texture descriptors that quantify differences in the average intensity values between adjacent rectangular regions. The following figure illustrates several simple Haar-like filters that
are commonly employed in feature extraction applications. 

<img src="images/Haar_like_F2.jpg" alt="Centered Image" style="display: block; margin: auto;" width="800">

As illustrated in above figure, Haar-like filters are commonly represented as combinations of two or more rectangular regions composed of black and white pixels. 
This figure showcases various examples of Haar-like filters, with the default weights clearly indicated on their respective rectangles. These filters can be applied for facial feature extraction as is shown in the next figure:

<img src="images/fig2222.png" alt="Centered Image" style="display: block; margin: auto;" width="600">

The feature value g for a Haar-like filter is defined as follows:

*g(x) = v1 m1(x) + v2 m2(x),* 

where x is an image, and m1 and m2 denote the mean intensities of the pixels within the black and white regions of the filter, respectively. The weights v1 and v2 correspond to these regions and are typically represented as two integers whose sum equals zero.
Numerous algorithms are available for determining the optimal values of weights. This code focuses specifically on identifying optimal Haar-like filters characterized by equal black and white regions. Then, the weights are assigned as v1 = −1 and v2 = 1.

Paper [[1]] introduces novel filters as extreme cases of the Haar-like filters, named **fully dispersed Haar-like filters**. A distinctive feature of these new filters is their adaptability, allowing pixels to reposition themselves dynamically to optimize the detection of local features. These filters mark a significant advancement within the Haar-like framework, merging ease of use with improved accuracy in feature detection. To mitigate the risk of overfitting, an optimization algorithm is developed in [[1]] that facilitates the creation of locally
optimized dispersed Haar-like filters, specifically targeting regions of the face to enhance detection precision. The approach is not limited to face detection; it also extends to facial expression recognition across seven distinct classes. The experimental results presented
in [[1]] demonstrate the superior performance of the newly optimized Haar-like filters, affirming their effectiveness in practical applications.

Then a novel code is proposed here based on the algorithm presenten in [[1]] to identify optimal fully dispersed Haar-like filters for enhanced facial feature extraction and recognition. Unlike traditional Haar-like filters, these novel filters allow pixels to move freely within images, enabling more effective capture of intricate local features. Through extensive experiments on face detection, the optimized filters can distinguish between face images and clutter with minimal error, outperforming the algorithm presented in [[1]]. The following image displays the optimal Haar-like filters for face feature extraction, illustrating the variation in *filter size* from small to large. 

<img src="images/fig22.png" alt="Centered Image" style="display: block; margin: auto;" width="800">

The face and clutter images are distingushed linearly by the use of the fully dispersed Haar-like filters as is shown in the second row of the above figure. Each column of this figure can be one of the outputs generated by this code. These filters achieve high accuracy, exceeding 98%, as demonstrated in the results of the code.

These filters also can be extracted for the facial experession recognaition with distinct emotional classes. Experiment results show the Haar-like features lead 86% and 94% accuracy when the linear and quadratic SVM are applied for facial experession recognaition, respectively. Further details regarding the newly proposed filters and their results can be found in [[1]]. 
Interested readers are encouraged to refer to that source.

[1]: https://arxiv.org/abs/2404.10476

## Contents
- **MATLAB Code**: The main algorithm implemented in MATLAB for feature Extraction of face images process. Details of the algorithm is presented in [[1]].
- **Datasets**: Two data files containing the clutter and face images used in this project.
  - `Clutter2.mat`: Contains clutter data for training and testing.
  - `Pics.mat`: Contains face images for training and testing.

Some face and clutter images applied in this research are shown in the next figure.

<img src="images/FaceClutter.png" alt="Centered Image" style="display: block; margin: auto;" width="800">
 
The two-dimensional face and clutter images are resized to 64 × 64 and converted into one dimensional vectors by arranging the pixels contained in the images. In this situation, an
image of size 64 × 64 is transformed to a row vector of length 4096 and inserted in a dataset as a row.

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
   load('Pics.mat');
   load('Clutter2.mat');
   ```
   "Pics" matrix is data matrix of face images.  1477 face images of size 64 × 64 are vectorized and inserted in the matrix. Then the matrix is of size 1477×4096.
   One can replace his data matrix instead of the matrix .
   In this situation parameter s_pic which shows the size if studied images (64 × 64) has to be updated. The same statements are also valid for clutter matrix "Clutter2". 

4. Run the script to start feature Extraction process.
   
   Before running the code, you can change the following paramers:
   div=0.7 (The ratio of training to testing samples ),
   num1=256 (the number of black pixels of the filter),
   num2=256 (the number of white pixels of the filter) ,
   Wh=[-1,1] (the weights of black and white parts of the filter),
   itter=200 (the number of iterations for training the filter).
   
6. View the results in the MATLAB workspace.
   
   The results include the graph of the optimized **fully dispersed Haar-like filter**:
<img src="images/filter_matlab.png" alt="Centered Image" style="display: block; margin: auto;" width="200">

and the graph of the accuracy of the filter can be seen as a result of the code. 
The accuracy graph includes the error of Haar-like filter for classification of train and test images in each iteration of the algorithm :
   
<img src="images/result_matlab4.png" alt="Centered Image" style="display: block; margin: auto;" width="400">

Then the distribution of mean measurment of test images is shown:

<img src="images/result_matlab3.png" alt="Centered Image" style="display: block; margin: auto;" width="400">

And the distribution of mean measurment of train images:

<img src="images/result_matlab2.png" alt="Centered Image" style="display: block; margin: auto;" width="400">

these results show the efficiency of the Haar-like filter to distinguish the face and clutter images. 
The accuracy of the classification also is reported in the matlab windows.

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
- **Paper**: (https://arxiv.org/abs/2404.10476)
- **Dataset**: [Clutter2.mat](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD/blob/master/Clutter2.mat) and [Pics.mat](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD/blob/master/Pics.mat)
- **GitHub Repository**: [https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD)








