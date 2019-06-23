f =imread('Fig0335.tif');
figure(1),imshow(f);
gm = medfilt2(f);
 figure(2),imshow(gm);
% gms = medfilt2(f,'symmetric');
% figure(3),imshow(gms);
