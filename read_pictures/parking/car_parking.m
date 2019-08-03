% RGB=imread('check02.png');
% figure(1),imshow(RGB),title('check02_color');
% I=rgb2gray(RGB);
% figure(2),imshow(I),title('check02_gray');
% imwrite(I,'check02_grb2gray.jpg')


f=imread('check02_grb2gray.jpg');
g2=adapthisteq(f, 'NumTiles', [2 2], 'ClipLimit', 0.05);

imshow(g3);
imshow(g2);
