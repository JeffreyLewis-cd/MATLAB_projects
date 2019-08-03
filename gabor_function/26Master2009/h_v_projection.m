
clc
close all
%% ??????
%andy01=imread('andy.jpg');
%andy_gray=rgb2gray(andy01);
%figure,imshow(andy_gray);
%imwrite(andy_gray,'andy_gray.tiff');
% a=imread('andy_gray.tiff');
% a_1 = imcrop(a,[100,0,280,360]);
% figure,imshow(a_1);
% imwrite(a_1,'andy_face.tiff');

% I=imread('andy_face.tiff');
I=imread('KA.HA4.32.tiff');
figure,imshow(I);
% I=rgb2gray(I);
[m, n]=size(I);

% ????????????
for y=1:n
     S(y)=sum(I(1:m,y));
end
y=1:n;
figure
subplot(211),plot(y,S(y));
title('Vertical Projection');

% ????????????
for x=1:m
    S(x)=sum(I(x,:));
end
x=1:m;
subplot(212),plot(x,S(x));

title('Horizontal Projection');

%cut area of eyes
% pic_1 = imcrop(I,[50,185,180,30]);
pic_1 = imcrop(I,[75,116,110,26]);
figure,imshow(pic_1);



