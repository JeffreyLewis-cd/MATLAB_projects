I=imread('yuan01_gray.jpg');
figure
imshow(I)
K=imadjust(I,[0.3 0.7],[]);
figure
imshow(K)
imwrite(K,'yuan01_adjust01.jpg')

RGB=imread('yuan02.jpg','jpg'); %??????
figure(1),imshow(RGB),title('color_yuan02'); %??????
I=rgb2gray(RGB); %????????
figure(2),imshow(I),title('yuan02_gray'); %?????