% 5 directions combined face image
% �ǣǣ� ������ȡ�Ļ���˼���ǽ�ͬһ�߶ȡ���ͬ����� �ǣ�������������ݶȷ��򹹽� �ǣ���������ں�ͼ

close all;

% img = imread('KA.HA4.32Resize.tiff');
% gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
% featureVector1 = gaborFeatures(img,gaborArray,4,4);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.

readImage=imread('KA.AN1.39.tiff');
% img2=rgb2gray(readImage);
gaborArray = gaborFilterBank(5,8,39,39);
featureVector2=gaborFeaturesArray(readImage,gaborArray,4,4);