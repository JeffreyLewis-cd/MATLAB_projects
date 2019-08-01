clear all
clc
close all
%% ??????
I=imread('KA.AN1.39.tiff');
figure,imshow(I);
% I=rgb2gray(I);
[m n]=size(I);

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