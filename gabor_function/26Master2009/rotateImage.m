
%rotate a image
im = imread('KA.HA4.32.tiff');
subplot(1,2,1)
imshow(im);

I3=imrotate(im,5,'bilinear','crop');
subplot(1,2,2)
imshow(I3);
