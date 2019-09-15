close all;

% img = imread('KA.HA4.32Resize.tiff');
% gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
% featureVector1 = gaborFeatures(img,gaborArray,4,4);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.

andyColor=imread('andy.jpg');
img2=rgb2gray(andyColor);
gaborArray = gaborFilterBank(5,8,39,39);
featureVector1=gaborFeatures(img2,gaborArray,4,4);
featureVector2=gaborFeaturesArray(img2,gaborArray,4,4);