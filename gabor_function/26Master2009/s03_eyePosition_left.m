
%binarize image
im = imread('KA.HA4.32R.tiff');
thresh = graythresh(im);
im2=imbinarize(im,'adaptive','ForegroundPolarity','dark','Sensitivity',0.02);
figure(1)
imshow(im2);

[m, n]=size(im2);

for y=76:120
     S(y)=sum(im2(118:138,y));
end
y=76:120;
figure(2)
subplot(211),plot(y,S(y));
title('Vertical Projection');

% x=99

for x=118:138
    S(x)=sum(I(x,76:120));
end
x=118:138;
subplot(212),plot(x,S(x));

title('Horizontal Projection');
% y=128

% mark the center of left eye
im(123:133,99 )=255;
im(128, 94:104)=255;
figure(3),imshow(im);


