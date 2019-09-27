% 输入参数说明：xsup为支持向量；w为产生相应的分类器的权值；b为产生响应的偏置；nbsv为储存每个分类器的支持向量的个数；cc为直方图均衡化
% 输出参数说明：yy为测试类别
% 函数作用：测试类别

function ypred2=svm_test(xsup,w,b,nbsv,cc)
addpath test1;
 mapping=getmapping(8,'u2');%LBP映射
        W=[2,1,1,1,1,1,2; ...
          2,4,4,1,4,4,2; ...
          1,1,1,0,1,1,1; ...
          0,1,1,0,1,1,0; ...
          0,1,1,1,1,1,0; ...
          0,1,1,2,1,1,0; ...
          0,1,1,1,1,1,0]; 

% file_path =  '.\test\';% 图像文件夹路径  
% img_path_list = dir(strcat(file_path,'*.jpg'));%获取该文件夹中所有jpg格式的图像  
% img_num = length(img_path_list);%获取图像总数量  
img_num = 1;
d=[];
for i=1:img_num
%    B=imread(strcat('.\test\',num2str(i),'.jpg'));
%    B=imread(cc);
%       B=rgb2gray(B);
%     imshow(B);
    X = double(cc);
      X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %采用'bilinear'：采用双线性插值算法扩展为64*64
  H2=DSLBP(X,mapping,W);%提取图片的LBP直方图
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %计算每个照片lpq直方图 
  a=[H2,lpqhist];
  d=[d;a];
%   disp(sprintf('完成表情测试集第%i张图片的小波特征提取',i));
end

P_test=d;
P_test=mapminmax(P_test,0,1);
%%%%%%%%以上是特征提取的部分
% test_label=load('test_label.txt');    %%读取测试样本的类别

%%%%%从这里开始是识别表情的算法，使用支持向量机来识别
addpath SVM-KM  %%添加支持向量机工具箱
c = 100;
%lambda = 1e-7;
kerneloption= 1.3;   %设置核参数
kernel='gaussian'; %设置高斯核作为支持向量机的核函数
% verbose = 0;
% nbclass=3;
[ypred2,maxi] = svmmultival(P_test,xsup,w,b,nbsv,kernel,kerneloption);   %测试集测试

disp('测试集的表情识别为：');
for i=1:length(ypred2)
    if ypred2(i)==1  disp('生气');
    elseif ypred2(i)==2    disp('厌恶');    
    elseif ypred2(i)==3    disp('恐惧');    
    elseif ypred2(i)==4    disp('高兴');
    elseif ypred2(i)==5    disp('悲伤');
    elseif ypred2(i)==6    disp('惊讶');
    end
 end
end