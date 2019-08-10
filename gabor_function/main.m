%parameter
%Usage: 
% [Eim, Oim, Aim] = ?spatialgabor(im, wavelength, angle, kx, ky, showfilter)
% im :这个是你要输入的图片，运行的过程中会进行灰度变换，名称随意命名
% wavelength:波长，以像素为单位构造的Gabor滤波器
% angle：过滤器的角度，单位为度；0角度意味着响应垂直特征的滤波器
% kx：控制带宽
% ky：控制方向选择；一般默认（kx,ky）设置为（0.5，0.5）
% showfilter：可选的标志0/1；当设置为1时，可以看到滤波器的图像，如果设置为0则看不到滤波器

img = imread('KA.HA4.32Resize.tiff');

%先将彩色图像转换为灰度图像
% grayimg = rgb2gray(img);
% subplot(1,2,1);
% imshow(grayimg);
% title('gray original image');
gim = im2double(img); 
figure;
% --v=2----------------------------------------------------------------------------------------------

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,-60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,1);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=-60'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,-45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,2);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=-45'); 

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,-30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,3);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=-30'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,0,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,4);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=0'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,5);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=30'); 




[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,6);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=45'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,7);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=60'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,2,90,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,8);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=2; u=90'); 



% --v=3----------------------------------------------------------------------------------------------

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,-60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,9);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=-60'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,-45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,10);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=-45'); 

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,-30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,11);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=-30'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,0,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,12);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=0'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,13);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=30'); 




[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,14);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=45'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,15);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=60'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,3,90,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,16);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=3; u=90'); 



% --v=4----------------------------------------------------------------------------------------------

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,-60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,17);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=-60'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,-45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,18);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=-45'); 

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,-30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,19);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=-30'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,0,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,20);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=0'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,21);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=30'); 




[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,22);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=45'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,23);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=60'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,4,90,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,24);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=4; u=90'); 





% --v=5----------------------------------------------------------------------------------------------

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,-60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,25);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=-60'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,-45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,26);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=-45'); 

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,-30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,27);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=-30'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,0,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,28);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=0'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,29);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=30'); 




[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,30);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=45'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,31);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=60'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,5,90,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,32);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=5; u=90'); 



% --v=6----------------------------------------------------------------------------------------------

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,-60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,33);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=-60'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,-45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,34);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=-45'); 

[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,-30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,35);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=-30'); 


[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,0,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,36);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=0'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,30,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,37);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=30'); 




[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,45,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,38);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=45'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,60,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,39);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=60'); 



[Eim,Oim,Aim,evenFilter]  = spatialgabor(gim,6,90,0.5,0.5,0);%spatialgabor(im, wavelength, angle, kx, ky, showfilter)
subplot(5,8,40);
% imshow(evenFilter,[]);
imshow(Aim);
title('v=6; u=90'); 
