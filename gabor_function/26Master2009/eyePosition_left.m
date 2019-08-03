
%binarize image
im = imread('KA.AN1.39.tiff');
thresh = graythresh(im);
im2=imbinarize(im,'adaptive','ForegroundPolarity','dark','Sensitivity',0.02);
figure(1)
imshow(im2);

[m, n]=size(im2);

for y=75:119
     S(y)=sum(im2(120:140,y));
end
y=75:119;
figure(2)
subplot(211),plot(y,S(y));
title('Vertical Projection');

% x=99

for x=120:140
    S(x)=sum(I(x,:));
end
x=120:140;
subplot(212),plot(x,S(x));

title('Horizontal Projection');
% y=129

% mark the center of left eye
im(124:134,99 )=255;
im(129, 95:104)=255;
figure(3),imshow(im);


