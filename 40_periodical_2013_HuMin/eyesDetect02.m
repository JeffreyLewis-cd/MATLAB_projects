clear all;
I= imread('andy.jpg');
I=rgb2gray(I);
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I);
x=length(BB(:,4));

%To detect Eyes
I2 = imcrop(I,BB(x,:));
figure,imshow(I2),title('detect Eyes');
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');

%To detect the left
% na1 = I2(:, 1 : floor(end/2.3));
% figure,imshow(na1),title('detect the left');

%To detect the right
% na2 = I2(:, floor(end/(2.24))+1 : end );
% figure,imshow(na2),title('detect the right');