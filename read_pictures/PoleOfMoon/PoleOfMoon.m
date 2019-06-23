f=imread('Fig0338.tif');
figure(1);imshow(f)


w=[0 1 0; 1 -4, 1; 0 1 0];
g1=imfilter(f, w, 'replicate');
figure(2);imshow(g1, [ ]);imwrite(g1,'figure(2).tif');

f2=tofloat(f);
figure(3);imshow(f2);imwrite(f2,'figure(3).png');
g2=imfilter(f2, w,  'replicate');
figure(4);imshow(g2, [ ]);imwrite(g2,'figure(4).png');

g=f2  - g2;
figure(5); imshow(g);imwrite(g,'figure(5).png');
