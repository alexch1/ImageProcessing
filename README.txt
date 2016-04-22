# ImageProcessing_ReflectionRemoval
##### Hoding my CA scripts

*****************************************************************************************
**                                         README                                     
*****************************************************************************************
**
**	NOTE 1: Pls make sure that all the '.m' scripts are under a same directory.
**	NOTE 2: You can add your own testing images under the path of /test_images;
**              Please classify them into two classes, i.e., images for intrinsic 
**              images decomposition purpose (under /test_images/intrinsic_images, 
**              and should be 'png’ format) and images for reflection removal purpose
**              (under /test_images/reflection_removal, and should be 'jpg' format).
**	NOTE 3:  To use MIT’s Local Mean Square Error (LMSE)[5] method to test the 
**              the 'quality' of output images, please refer the ATTACHMENT.
**
**	RUN THE CODE:
**	1) Open 'main.m' in MATLAB;
**	2) Change the value of lambda which control the smoothness if you want; 
**	3) Run 'main.m', wait for 'ALL DONE' shown in the command window;
**	4) Check the detailed results in 'results_log.txt' & 'results_images' folder.
**
**
**	Copyrights info:
**	1) This code is written by myself and it is adapted from algorithms published
**   	   in "Single Image Layer Separation using Relative Smoothness" (Y. Li et al.,
**   	   CVPR 2014) and "Ground truth dataset and baseline evaluations for intrinsic
**   	   image algorithms" (R. Grosse et al., ICCV 2009).
**	2) Some testing images under "test_images" folder are copied from MIT intrinsic 
**   	   image dataset and from the testing dataset of " Exploiting Reflection Change 
**   	   for Automatic Reflection Removal" (Y. Li et al., ICCV 2013).
**
**
**                                                                              CHI JI
**                                                                  E0001795@u.nus.edu
**
*****************************************************************************************
*****************************************************************************************





                                      ATTACHMENT
#########################################################################################

NOTE: Copied from MIT intrinsic image dataset.


The code is under the 'MIT-intrinsic' folder.
The data are available at: 
* http://people.csail.mit.edu/rgrosse/intrinsic/intrinsic-data.tar.gz

Unpack the tarballs and merge if necessary. The top-level folder, named
MIT-intrinsic by default, should contain the README, four python
files, the data folder, and two empty results folders.

The four python files are:
* comparison.py: the script for performing hold-one-out cross-validation.
* intrinsic.py: all of the intrinsic image algorithms, along with functions
        for reading the data and computing the error scores
* poisson.py: functions for solving the Poisson equation using least-squares or L1.
* html.py: a utility for saving results to HTML.

After installing the required packages (see below), you should be able to
reproduce most of the results from the paper by running comparison.py:

   cd MIT-intrinsic
   python comparison.py

This will evaluate the algorithms using hold-one-out cross-validation. It prints
results to the console, and also saves the shading/reflectance decompositions and
their error scores to the HTML file results/index.html. If you set the USE_L1
variable (defined in comparison.py) to True, it will use the L1 penalty for reconstruction
rather than least squares. In this case, the outputs will be saved to results_L1/index.html.

We have done our best to provide a code base which is readable, compact, and easy to
extend.

Please send your questions and comments to Roger Grosse (rgrosse@mit.edu).



############################## Installation ###########################

To run the code, you will need Python as well as the following
Python libraries:
* NumPy
* SciPy
* PyPNG
* PyAMG

#########################################################################################


