detector=vision.CascadeObjectDetector('LeftEyeCART');
input_image=imread('KA.AN1.39.tiff');
figure();imshow(input_image);title('ԭͼ');
gauss_image=imgaussfilt(input_image,1);
eyes=step(detector,gauss_image);
