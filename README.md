# Project Title: Fully Dispersed Haar-like Filters for Face Detection

## Description
This repository contains the MATLAB code and datasets related to the manuscript titled **Enhanced Facial Feature Extraction and Recognition Using Optimal Fully Dispersed Haar-like Filters**, which has been submitted to **[The Visual Computer Journal](https://link.springer.com/journal/371)**. The manuscript is authored by **Z. Sedaghatjoo, H. Hosseinzadeh, and A. Shirzadi**.

Haar-like filters are renowned for their simplicity, speed, and accuracy in various computer vision tasks. Haar-like features are local texture descriptors that quantify differences in the average intensity values between adjacent rectangular regions. The following figure illustrates several simple Haar-like filters that are commonly employed in feature extraction applications: 

<img src="images/Haar_like_F2.jpg" alt="Centered Image" style="display: block; margin: auto;" width="800">

As illustrated in the figure, Haar-like filters are commonly represented as combinations of two or more rectangular regions composed of black and white pixels.  
This figure showcases various examples of Haar-like filters, with the default weights clearly indicated on their respective rectangles.
These filters can be applied for facial feature extraction, as shown in the next figure:

<img src="images/fig2222.png" alt="Centered Image" style="display: block; margin: auto;" width="600">

The feature value g for a Haar-like filter is defined as follows:

*g(x) = v1 m1(x) + v2 m2(x),* 

where x is an image, and m1 and m2 denote the mean intensities of the pixels within the black and white regions of the filter, respectively. The weights v1 and v2 correspond to these regions and are typically represented as two integers whose sum equals zero.
Numerous algorithms are available for determining the optimal values of weights. This code focuses specifically on identifying optimal Haar-like filters characterized by equal black and white regions. Then, the weights are assigned as v1 = −1 and v2 = 1.

We introduce novel filters as extreme cases of the Haar-like filters, named **fully dispersed Haar-like filters**. A distinctive feature of these new filters is their adaptability, allowing pixels to reposition themselves dynamically to optimize the detection of local features. These filters mark a significant advancement within the Haar-like framework, merging ease of use with improved accuracy in feature detection. To mitigate the risk of overfitting, an optimization algorithm is developed by the authors that facilitates the creation of locally
optimized dispersed Haar-like filters, specifically targeting regions of the face to enhance detection precision. The approach is not limited to face detection; it also extends to facial expression recognition across seven distinct classes. The experimental results demonstrate the superior performance of the newly optimized Haar-like filters, affirming their effectiveness in practical applications.

Then a novel code is proposed here to identify optimal fully dispersed Haar-like filters for enhanced facial feature extraction and recognition. Unlike traditional Haar-like filters, these novel filters allow pixels to move freely within images, enabling more effective capture of intricate local features. Through extensive experiments on face detection, the optimized filters can distinguish between face images and clutter with minimal error. The following image displays the optimal Haar-like filters for face feature extraction, illustrating the variation in *filter size* from small to large. 

<img src="images/fig22.png" alt="Centered Image" style="display: block; margin: auto;" width="800">

The face and clutter images are distingushed linearly by the use of the fully dispersed Haar-like filters as is shown in the second row of the above figure. Each column of this figure can be one of the outputs generated by this code. These filters achieve high accuracy, exceeding 98%, as demonstrated in the results of the code.

These filters also can be extracted for the facial experession recognaition with distinct emotional classes. Experiment results show the Haar-like features lead 86% and 94% accuracy when the linear and quadratic SVM are applied for facial experession recognaition, respectively. One can refer [[Haar-like-filter-FER]](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FER) to see the code of facial experession recognaition task by the new Haar-like filters.

## Contents
- **MATLAB Code**: The main algorithm for feature extraction of face images. 
- **Datasets**: 
  - [Google Drive Link to Datasets](https://drive.google.com/drive/folders/1XOVwqI72RaLmJrDujGvBX3SMNUjKxVut?usp=drive_link)

Some face and clutter images applied in this research are shown in the figure below:

<img src="images/FaceClutter.png" alt="Centered Image" style="display: block; margin: auto;" width="800">
---

### Data Splitting for Training and Testing
To ensure robust evaluation and prevent overfitting, the datasets are split into training and test sets. Below is the detailed description of this process:

1. **Random Splitting**:
   - The dataset is randomly shuffled using MATLAB's `randperm` function for each execution of the code.
   - The split ratio is set to `70%` training and `30%` testing by default, controlled by the parameter `div`.

2. **Training Data**:
   - The first `70%` of the shuffled data is assigned to the training set.
   - For example, in the **Face_UTK** dataset with 9456 samples, approximately 6619 samples are used for training.

3. **Test Data**:
   - The remaining `30%` of the data is assigned to the test set.
   - For example, in the **Face_UTK** dataset, the test set contains approximately 2837 samples.

4. **Clutter Data**:
   - Similarly, the clutter dataset is split into training and testing sets using the same ratio. For the **Clutter1** dataset with 2000 samples:
     - Training samples: ~1400.
     - Testing samples: ~600.

5.**Randomization and Robustness**:
   The dataset is randomly split into training (70%) and testing (30%) sets for each execution using MATLAB's `randperm` function. This ensures that the algorithm is evaluated under varying data distributions, simulating real-world scenarios. 

   To assess the robustness and generalizability of the proposed method, the algorithm is executed 20 times with different random splits, and the final results are reported as the **average error** and **average accuracy** across all runs. This approach eliminates the dependence on a single data split and demonstrates the overall effectiveness of the method in diverse conditions.

   **Note:** Since no fixed seed is used, the specific training and testing splits vary across executions, leading to slight variations in results. This variability reflects the practical applicability and reliability of the proposed algorithm.


6. **Mean Feature Calculation**:
   - After splitting, the mean features of the training data are computed to initialize the Haar-like filters.

7. **Multiple Runs**:
   - The code can be executed multiple times to generate various splits and compute average performance metrics, ensuring the algorithm's robustness.

#### Example Code for Splitting:
```matlab
% Face data splitting
ind = randperm(size(dataF, 1));
data = dataF(ind, :);
Ntrain = round(div * size(dataF, 1));
traindata = data(1:Ntrain, :);
testdata = data(Ntrain+1:end, :);

% Clutter data splitting
NCtrain = round(div * size(dataC, 1));
cluttertrain = dataC(1:NCtrain, :);
cluttertest = dataC(NCtrain+1:end, :);
```


---

### Face Databases and Clutter Matrices:

This repository contains four face image datasets represented as matrices, along with clutter matrices used for processing and analysis. Below are detailed descriptions of the datasets and their corresponding clutter matrices:

 1. **Face_CFD**
- **Matrix Size:** `1410 x 4096`  
  Each row represents a face image, where the original image size is `64 x 64` pixels.  
- **Clutter Matrix:**  
  **Clutter1** (`2000 x 4096`) was used for this dataset.

 2. **Face_AR**
- **Matrix Size:** `2600 x 4096`  
  Each row represents a face image of size `64 x 64` pixels.  
- **Clutter Matrix:**  
  **Clutter1** (`2000 x 4096`) was also used for this dataset.

 3. **Face_MIT_CMU**
- **Matrix Size:** `2770 x 400`  
  Each row corresponds to a face image of size `20 x 20` pixels.  
- **Clutter Matrix:**  
  **Clutter20** (`200 x 400`) was utilized for this dataset due to the smaller image dimensions.

 4. **Face_UTK**
- **Matrix Size:** `9456 x 4096`  
  Each row represents a face image of size `64 x 64` pixels.  
- **Clutter Matrix:**  
  **Clutter1 (Extended)** (`10675 x 4096`) was used for this dataset.

---

 **Clutter Matrices**
- **Clutter1** (`2000 x 4096`): Used for Face_CFD and Face_AR datasets.  
- **Clutter20** (`200 x 400`): Used for the Face_MIT_CMU dataset.  
- **Clutter1 (Extended)** (`10675 x 4096`): Used for the Face_UTK dataset.

---

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD.git
   ```

2. Ensure you have MATLAB **R2020b** or newer installed.

---
### Usage
1. Open the MATLAB script **Fully_Dispersed_HaarLike.m**.
2. Download the dataset from [Google Drive](https://drive.google.com/drive/folders/1XOVwqI72RaLmJrDujGvBX3SMNUjKxVut?usp=drive_link).  
3. Load the dataset files in MATLAB:
   ```matlab
   load('Face.mat');
   load('Clutter.mat');
   ```
   **Note**: Replace `'Face.mat'` and `'Clutter.mat'` with the actual names of the dataset files downloaded from the Google Drive link. For example, if the file is named `Face_AR.mat`, replace `'Face.mat'` with `'Face_AR.mat'`.

4. Run the script to start the feature extraction process.  
5. Optional: Adjust the following parameters before running the code:
   - **`div`**: Training-to-testing ratio (default: `0.7`)  
   - **`num1`**: Number of black pixels in the filter (default: `256`)  
   - **`num2`**: Number of white pixels in the filter (default: `256`)  
   - **`Wh`**: Weights of the black and white parts (default: `[-1, 1]`)  
   - **`itter`**: Number of iterations for training (default: `200`)
   - **`s_pic`**: Size of each image in data (default: `64`)
  
---
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

These results show the efficiency of the Haar-like filter to distinguish the face and clutter images. 
The accuracy of the classification also is reported in the MATLAB workspace.

## Contribution Guidelines
We welcome contributions to improve the algorithm, code, or documentation. If you'd like to contribute, please:
1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Make your changes and test them.
4. Create a pull request with a detailed description of your changes.


## Citation
If you use this code or dataset, please cite the following article:  

Enhanced Facial Feature Extraction and Recognition Using Optimal Fully Dispersed Haar-like Filters 
Submitted to *The Visual Computer* (Under Review), 2025.  
Once accepted, the full citation with DOI will be updated here.


## Links
- **Dataset**: [Google Drive Link to Datasets](https://drive.google.com/drive/folders/1XOVwqI72RaLmJrDujGvBX3SMNUjKxVut?usp=drive_link)
- **GitHub Repository**: [https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD](https://github.com/Sedaghatjoo/fully-dispersed-Haar-like-filter-FD)
