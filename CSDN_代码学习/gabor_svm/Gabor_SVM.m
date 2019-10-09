% Palmprint recognition  based on Gabor and SVM (the toolbox LS_SVM is used)
% Wen Changzhi 2006/10/27

clc,clear,close all;
% extract festures then save them
% enter 100 images from 10 person, caculate the feature vector. 
% for i=0:99
%     for j=1:6
%         image=imread(strcat('P_',num2str(i),'_',num2str(j),'.bmp'));
%         tempV=Gabor_SVM_palm(image);
%         eval(['save Gabor_SVM\F_' num2str(i) '_'  num2str(j) ' tempV;']);       
%         end
%     end
%  
% classified by SVM classifier
% create training samples and testing samples
F_train=[];
F_test=[];
 for i=0:99
      for j=1:3
          eval(['load Gabor_SVM\F_' num2str(i) '_'  num2str(j) ';']); 
          F_train=[F_train , tempV'];%training samples
          clear tempV;
      end
      for j=4:6
           eval(['load Gabor_SVM\F_' num2str(i) '_'  num2str(j) ';']);
           F_test=[F_test, tempV'];% testing samples
           clear tempV;
       end                 
  end
  % create the aimed samples
  
  C_train=[];
  C_test=[];
  for i=1:100
      C_train=[C_train, i*ones(1,3)];
      C_test=[C_test,i*ones(1,3)];
  end
  
  % determined parameters for the SVM classifier  
  type = 'c';
  kernel_type = 'RBF_kernel';
  gam = 381.2876;
  sig2 = 641.2349;
  preprocess = 'preprocess';
  codefct = 'code_MOC';  
  
  X = F_train'; % ѵ������
  Y = C_train'; % ѵ��Ŀ��
  Xt = F_test'; % ��������
  Yt = C_test'; % ����Ŀ��
  
  % encode
  
  [Yc,codebook,old_codebook]=code(Y,codefct);
  [gam,sig2] = tunelssvm({X,Yc,type,gam,sig2,kernel_type,preprocess});
  
  [alpha,b] = trainlssvm({X,Yc,type,gam,sig2,kernel_type,preprocess});           % ѵ��
  Yd0 = simlssvm({X,Yc,type,gam,sig2,kernel_type,preprocess},{alpha,b},Xt);      % ����
  
  Yd = code(Yd0,old_codebook,[],codebook);
  
  Result = ~abs(Yd-Yt)              % ��ȷ������ʾΪ1
  Percent = sum(Result)/length(Result)   % ��ȷ������
         