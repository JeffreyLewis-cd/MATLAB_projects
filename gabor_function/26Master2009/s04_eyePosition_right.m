
%binarize image
im = imread('KA.HA4.32R.tiff');
thresh = graythresh(im);
im2=imbinarize(im,'adaptive','ForegroundPolarity','dark','Sensitivity',0.02);
figure(1)
imshow(im2);

[m, n]=size(im2);

for y=142:186
     S(y)=sum(im2(118:138,y));
end
y=142:186;
figure(2)
subplot(211),plot(y,S(y));
title('Vertical Projection');

% x=159

for x=118:138
    S(x)=sum(I(x,142:186));
end
x=118:138;
subplot(212),plot(x,S(x));

title('Horizontal Projection');
% y=127

% mark the center of left eye
im(122:132,159 )=255;
im(127, 154:164)=255;
figure(3),imshow(im);


