
CAT_DOG_IMAGE CLASSIFICATION:
This classification using Edge detection with 2 different method 2-D Discrete Haar Wavelet Transform (DWT) and Laplacian filter.

Using Edge Detection > PCA > FDA

# Files
==============================================================

With Wavelet

Main Program
1. test_cat_dog_1.m
2. test_load_exc.m (work)
   
Functions

* waveFDA.m
* wavelet.m
* FDA.m
  
Workflow

* test_load_exc.m
* test_load_exc.m manggil waveFDA.m
* waveFDA.m manggil wavelet.m dan FDA.m


==============================================================

With Lapician Filter

Main Program

* test_cat_dog_2.m
* test_load_exc_2.m (work)
  
Functions

* maskFDA.m
* mask.m

Workflow

* test_load_exc_2.m
* test_load_exc_2.m manggil maskFDA.m
* waveFDA.m manggil mask.m
