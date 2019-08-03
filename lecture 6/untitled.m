im = imread('crater02.jpg');
imshow(im);
h = [0 -1 0; -1 5 -1; 0 -1 0];
whos
  Name        Size                  Bytes  Class     Attributes

  h           3x3                      72  double              
  im        848x1412x3            3592128  uint8               

out = imfilter(im,h);
figure(2),imshow(out);
figure(2),imshow(out);
h = [0 -1 0; -1 10 -1; 0 -1 0];
out = imfilter(im,h);
figure(3),imshow(out);

h = [0 -1 0; -1 7 -1; 0 -1 0];
out = imfilter(im,h);
figure(4),imshow(out);

h = [0 -1 0; -1 6 -1; 0 -1 0];
out = imfilter(im,h);
figure(5),imshow(out);

h = [0 -2 0; -2 5 -2; 0 -2 0];
out = imfilter(im,h);
figure(6),imshow(out);

h = [0 -1 0; -1 6 -1; 0 -1 0];
h = [0 -2 0; -2 2 -2; 0 -2 0];
out = imfilter(im,h);
figure(7),imshow(out);
