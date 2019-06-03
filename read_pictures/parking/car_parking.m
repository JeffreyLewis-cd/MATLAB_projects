% RGB=imread('check02.png');
% figure(1),imshow(RGB),title('check02_color');
% I=rgb2gray(RGB);
% figure(2),imshow(I),title('check02_gray');
% imwrite(I,'check02_grb2gray.jpg')


f=imread('check02_grb2gray.jpg');
 g2=imadjust(f,[0.5 0.75],[0 1]);
 figure(1),imshow(g2);
 imwrite(g2,'fish01_0.5-0.75.jpg');