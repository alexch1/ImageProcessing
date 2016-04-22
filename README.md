# ImageProcessing_ReflectionRemoval
##### Hoding my CA scripts
<br />
                                         README                                          <br />
_________________________________________________________________________________________<br />
                                                                                       <br />
	NOTE 1: Pls make sure that all the '.m' scripts are under a same directory.          <br />
	NOTE 2: You can add your own testing images under the path of /test_images;          <br />
              Please classify them into two classes, i.e., images for intrinsic        <br />
              images decomposition purpose (under /test_images/intrinsic_images,      <br />
              and should be 'png’ format) and images for reflection removal purpose     <br />
              (under /test_images/reflection_removal, and should be 'jpg' format).    <br />
	NOTE 3:  To use MIT’s Local Mean Square Error (LMSE)[5] method to test the          <br />
              the 'quality' of output images, please refer the ATTACHMENT.              <br />
                                                                                          <br />
	RUN THE CODE:                                                                           <br />
	1) Open 'main.m' in MATLAB;                                                                 <br />
	2) Change the value of lambda which control the smoothness if you want; <br />
	3) Run 'main.m', wait for 'ALL DONE' shown in the command window;<br />
	4) Check the detailed results in 'results_log.txt' & 'results_images' folder.<br />
<br />
  Copyrights info:<br />
  1) This code is written by myself and it is adapted from algorithms published<br />
   	   in "Single Image Layer Separation using Relative Smoothness" (Y. Li et al.,<br />
   	   CVPR 2014) and "Ground truth dataset and baseline evaluations for intrinsic<br />
   	   image algorithms" (R. Grosse et al., ICCV 2009).<br />
  2) Some testing images under "test_images" folder are copied from MIT intrinsic <br />
   	   image dataset and from the testing dataset of " Exploiting Reflection Change <br />
   	   for Automatic Reflection Removal" (Y. Li et al., ICCV 2013).<br />
<br />
                                                                              CHI JI<br />
                                                                  E0001795@u.nus.edu<br />
_________________________________________________________________________________________<br />
<br />
                                      ATTACHMENT<br />
_________________________________________________________________________________________<br />
<br />
NOTE: Copied from MIT intrinsic image dataset.<br />
<br />
The code is under the 'MIT-intrinsic' folder.<br />
The data are available at: <br />
* http://people.csail.mit.edu/rgrosse/intrinsic/intrinsic-data.tar.gz<br />
<br />
Unpack the tarballs and merge if necessary. The top-level folder, named<br />
MIT-intrinsic by default, should contain the README, four python<br />
files, the data folder, and two empty results folders.<br />
<br />
The four python files are:<br />
comparison.py: the script for performing hold-one-out cross-validation.<br />
intrinsic.py: all of the intrinsic image algorithms, along with functions<br />
        for reading the data and computing the error scores<br />
poisson.py: functions for solving the Poisson equation using least-squares or L1.<br />
html.py: a utility for saving results to HTML.<br />
<br />
After installing the required packages (see below), you should be able to<br />
reproduce most of the results from the paper by running comparison.py:<br />
<br />
cd MIT-intrinsic<br />
python comparison.py<br />
<br />
This will evaluate the algorithms using hold-one-out cross-validation. It prints<br />
results to the console, and also saves the shading/reflectance decompositions and<br />
their error scores to the HTML file results/index.html. If you set the USE_L1<br />
variable (defined in comparison.py) to True, it will use the L1 penalty for reconstruction<br />
rather than least squares. In this case, the outputs will be saved to results_L1/index.html.<br />
<br />
We have done our best to provide a code base which is readable, compact, and easy to<br />
extend.<br />
<br />
Please send your questions and comments to Roger Grosse (rgrosse@mit.edu).<br />
<br />

_________________________________ Installation __________________________________<br />
To run the code, you will need Python as well as the following<br />
Python libraries:<br />
NumPy<br />
SciPy<br />
PyPNG<br />
PyAMG<br />
__________________________________________________________________________________ <br />
<br />
