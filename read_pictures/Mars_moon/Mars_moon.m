f = imread('Fig0323.tif');
imshow(f)

f1 = histeq(f, 256);
figure(2),imshow(f1)

p = manualhist();
g = histeq(f, p);
imshow(g)
