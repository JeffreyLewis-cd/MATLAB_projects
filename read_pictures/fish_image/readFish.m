%%%%%%%%%%%%%%%%%%
% RGB=imread('fish01.jpg');
% figure(1),imshow(RGB),title('fish01_color');
% I=rgb2gray(RGB);
% figure(2),imshow(I),title('fish01_gray');
% imwrite(I,'fish01_grb2gray.jpg')

positive_fish=imread('fish01_grb2gray.jpg');
negative_fish=255 - positive_fish;
figure(1),imshow(negative_fish);
imwrite(negative_fish,'fish01_negative.jpg');