f =imread('Fig0338.tif');
w4=fspecial('laplacian', 0);
w8=[1 1 1; 1 -8 1; 1 1 1];
f = tofloat(f);
g4 =f - imfilter(f, w4, 'replicate');
g8 =f - imfilter(f, w8, 'replicate');
figure(1);imshow(f);

figure, imshow(g4);
imwrite(g4,'g4.png');

figure, imshow(g8);
imwrite(g8,'g8.png');