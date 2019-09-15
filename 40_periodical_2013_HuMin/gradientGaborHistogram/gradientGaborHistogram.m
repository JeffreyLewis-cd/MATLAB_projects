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

[u,v] = size(featureVector2);
fvArray = featureVector2;
featureDirectionCombined = cell(u,1);
for i = 1:u
   [a,b] = size(readImage);
   featureDirectionCombined{i,1} = zeros(a,b);
    for j = 1:v
      featureDirectionCombined{i,1} =  featureDirectionCombined{i,1} + fvArray{i,j};
    end
end

[c,d] = size(featureDirectionCombined);
figure('NumberTitle','Off','Name','gabor row combined image');
for i = 1:c
    for j = 1:d        
        subplot(c,d,(i-1)*d+j)    
        imshow(featureDirectionCombined{i,j},[]);
        title({  ['c = ',num2str(i), ',d = ',num2str(j)] } );
    end
end