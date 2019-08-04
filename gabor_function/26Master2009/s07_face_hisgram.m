H = imread('KA.HA4.32Resize.tiff');
if length(size(H))>2
    H=rgb2gray(H);  
end
%original
subplot(3,2,1);  
imshow(H); title('original image');  
subplot(3,2,2);  
imhist(H); title('original image histogram');  

%method 01
subplot(3,2,3);  
H1=adapthisteq(H);  
imshow(H1); title('adapthisteq equalization');  
subplot(3,2,4);  
imhist(H1);title('adapthisteq equalization histogram');  

%method 02
subplot(3,2,5);  
H2=histeq(H);  
imshow(H2); title('histeq equalization');  
subplot(3,2,6);  
imhist(H2); title('histeq equalization histogram'); 

imwrite(H2,'KA.HA4.32His.tiff');
