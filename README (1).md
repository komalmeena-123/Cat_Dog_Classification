# Cat Dog Classification

*Note : I just edit small detail about the code, original owner and maker code by "HYO JIN CHUNG AND MINH N. TRAN" from their Paper with Title "IMAGE RECOGNITION FOR CATS AND DOGS"*

Link : http://web.csulb.edu/~jchang9/m521/m695_sp10_FinalReport_Minh_Angela.pdf


This classification using Edge detection with 2 different method 2-D Discrete Haar Wavelet Transform (DWT) and Laplacian filter.

Using Edge Detection > PCA > FDA

<img src="https://github.com/Yakagai17/Cat_Dog_Classification/blob/master/metod.JPG?" alt="Illustration" width="415px"/>
==============================================================<br>
# Files <br>
==============================================================<br>
<b>With Wavelet</b> 
<br><br>
Main Program 
 
1. test_cat_dog_1.m
2. test_load_exc.m (work)

Functions
1. waveFDA.m
2. wavelet.m
3. FDA.m

Workflow
1. test_load_exc.m
2. test_load_exc.m manggil waveFDA.m 
2. waveFDA.m  manggil wavelet.m dan FDA.m

<br><br>
==============================================================<br>
<b>With Lapician Filter</b> 


Main Program 
1. test_cat_dog_2.m
2. test_load_exc_2.m (work)

Functions
1. maskFDA.m
2. mask.m

Workflow
1. test_load_exc_2.m
2. test_load_exc_2.m manggil maskFDA.m
2. waveFDA.m  manggil mask.m

==============================================================
