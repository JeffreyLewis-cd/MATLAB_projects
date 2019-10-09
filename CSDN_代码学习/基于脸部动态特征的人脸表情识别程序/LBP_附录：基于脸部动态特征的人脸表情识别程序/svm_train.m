% 输出参数说明：xsup为支持向量；w为产生相应的分类器的权值；b为产生响应的偏置；nbsv为储存每个分类器的支持向量的个数；
% 函数作用：训练样本
function [xsup,w,b,nbsv]=svm_train()
clear;clc;
c=[];
addpath train1;
mapping=getmapping(8,'u2');%LBP映射
        W=[2,1,1,1,1,1,2; ...
          2,4,4,1,4,4,2; ...
          1,1,1,0,1,1,1; ...
          0,1,1,0,1,1,0; ...
          0,1,1,1,1,1,0; ...
          0,1,1,2,1,1,0; ...
          0,1,1,1,1,1,0]; 
      
      
for i=1:30
  B=imread(strcat('train1\','AN\',num2str(i),'.jpg'));
   X = double(B);
     X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为128*128
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  c=[c;a];%LPB和LPQ特征融合
  disp(sprintf('完成AN表情第%i张图片的小波特征提取',i));
end
%提取DI表情的特征
for i=1:29    
  B=imread(strcat('train1\','DI\',num2str(i),'.jpg'));  
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为128*128
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  c=[c;a];%LPB和LPQ特征融合
  disp(sprintf('完成DI表情第%i张图片的特征提取',i));
end
%提取FE表情的特征
for i=1:32
  B=imread(strcat('train1\','FE\',num2str(i),'.jpg'));  %读取fe类别的表情照片
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);%光照补偿
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为64*64
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  c=[c;a];%LBP和LPQ特征融合
  disp(sprintf('完成FE表情第%i张图片的特征提取',i));
end
%%%以下注释一样
%提取HA表情的特征
for i=1:32    
  B=imread(strcat('train1\','HA\',num2str(i),'.jpg'));  
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为128*128
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  c=[c;a];%LPB和LPQ特征融合
  disp(sprintf('完成HA表情第%i张图片的特征提取',i));
end

%提取SA表情的特征
for i=1:30    
  B=imread(strcat('train1\','SA\',num2str(i),'.jpg'));  
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为128*128
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  c=[c;a];%LPB和LPQ特征融合
  disp(sprintf('完成SA表情第%i张图片的特征提取',i));
end

for i=1:30
  B=imread(strcat('train1\','SU\',num2str(i),'.jpg'));
   X = double(B);
     X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为128*128
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  c=[c;a];%LPB和LPQ特征融合
  disp(sprintf('完成SU表情第%i张图片的小波特征提取',i));
end



P_train=c;
P_train=mapminmax(P_train,0,1);
%%%%%%%%以上是特征提取的部分
train_label=load('train_label.txt');  %%读取训练样本的类别

%%%%%从这里开始是识别表情的算法，使用支持向量机来识别
addpath SVM-KM  %%添加支持向量机工具箱
c = 100;
lambda = 1e-7;
kerneloption= 1.3;   %设置核参数
kernel='gaussian'; %设置高斯核作为支持向量机的核函数
verbose = 0;
nbclass=6;
[xsup,w,b,nbsv]=svmmulticlassoneagainstall(P_train,train_label,nbclass,c,lambda,kernel,kerneloption,verbose); %使用支持向量机进行训练获得支持向量
save('save.mat','xsup','w','b','nbsv');
end