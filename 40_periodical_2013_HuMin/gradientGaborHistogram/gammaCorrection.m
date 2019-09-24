img = imread('KA.AN1.39.tiff');
figure(1);
subplot(1,2,1);
imshow(img);

img02 = AGCWD(img); %gamma correction
subplot(1,2,2);
imshow(img02);