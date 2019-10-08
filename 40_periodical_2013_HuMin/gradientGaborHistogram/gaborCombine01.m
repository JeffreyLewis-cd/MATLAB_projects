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

% ͬһ�߶ȣ���ͬ���������ۼ�
[u,v] = size(featureVector2);
fvArray = featureVector2;
featureAccumulate = cell(u,1);
for i = 1:u
   [a,b] = size(readImage);
   featureAccumulate{i,1} = zeros(a,b);
    for j = 1:v
      featureAccumulate{i,1} =  featureAccumulate{i,1} + fvArray{i,j};
    end
end

% ����ƽ��ֵ
[c,d] = size(featureAccumulate);
figure('NumberTitle','Off','Name','gabor row combined image');
featureAverage = cell(c,1);

for i = 1:c
    for j = 1:d  
        featureAverage{i,1}=featureAccumulate{i,j}/8;
        subplot(c,1,i)   
        imshow(featureAverage{i,1},[]);
        title({  ['c = ',num2str(i), ',d = ',num2str(j)] } );
    end
end

%40����������ֵ������
figure('NumberTitle','Off','Name','40����������ֵ������');
[u,v] = size(featureVector2);
fvArray = featureVector2;
featureBinary = cell(u,v);
for i = 1:u
    for j = 1:v
      featureBinary{i,j} =  imbinarize(fvArray{i,j},featureAverage{i,1});      
      
      subplot(u,v,(i-1)*v+j)    
      imshow(featureBinary{i,j},[]);
      title({  ['u = ',num2str(i), ',v = ',num2str(j)] } );
    end
end

%40����������ֵ��ͼ��ͬһ�߶ȣ���ͬ�����ں�
figure('NumberTitle','Off','Name','40����������ֵ��ͼ��ͬһ�߶ȣ���ͬ�����ں�');
[m,n] = size(featureBinary);
feaBinaryCombine = cell(m,1);
for i = 1:m
    [j,k]=size(featureBinary{i,1});
    feaBinaryCombine{i,1}=zeros(j,k);
    for j = 1:n
      feaBinaryCombine{i,1} =feaBinaryCombine{i,1} + featureBinary{i,j};      
    end          
      subplot(m,1,i)    
      imshow(feaBinaryCombine{i,1},[]);
      title({  ['m = ',num2str(i), ',n = ',num2str(j)] } );
end

%�ݶȷ��������ں�
figure('NumberTitle','Off','Name','�ݶȷ��������ں�');
[p,q] = size(feaBinaryCombine);
feaBinaryGradient = cell(p,1);
for i = 1:p
    comItem =feaBinaryCombine{i,1};
    [r,s]=size(comItem);
    feaBinaryGradient{i,1} = zeros(r,s);
    graItem=zeros(r,s);
    for j = 1:r
        for k = 1:s
           if(comItem(j,k)<=3)
               graItem(j,k)=0;
           end
           
           if(comItem(j,k)>=4)
               graItem(j,k)=1;
           end
        end
  
    end 
      feaBinaryGradient{i,1}=graItem;
      subplot(p,1,i)    
      imshow(feaBinaryGradient{i,1},[]);
      title({  ['m = ',num2str(i), ',n = ',num2str(j)] } );
end
