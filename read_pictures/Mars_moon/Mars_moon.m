f = imread('Fig0323.tif');
% imshow(f)

% f1 = histeq(f, 256);
% figure(2),imshow(f1)
% 
% p = manualhist();
% g = histeq(f, p);
% imshow(g)

% g2 = adapthisteq(f, 'NumTiles', [25 25]);

g3=adapthisteq(f, 'NumTiles', [25 25], 'ClipLimit', 0.05);

imshow(g3)
