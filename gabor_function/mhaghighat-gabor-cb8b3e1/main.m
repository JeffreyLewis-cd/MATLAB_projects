img = imread('KA.HA4.32Resize.tiff');
close all;
gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
featureVector = gaborFeatures(img,gaborArray,4,4);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.
