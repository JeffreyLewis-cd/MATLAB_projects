
%rotate a image
im = imread('KA.HA4.32.tiff');
subplot(1,2,1)
imshow(im);

angle = atand((129 - 124)/(159 - 99))

I3=imrotate(im,angle,'bilinear','crop');
subplot(1,2,2)
imshow(I3);

imwrite(I3,'KA.HA4.32R.tiff')
