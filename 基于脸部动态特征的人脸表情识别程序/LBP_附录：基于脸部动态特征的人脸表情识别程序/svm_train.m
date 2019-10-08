% �������˵����xsupΪ֧��������wΪ������Ӧ�ķ�������Ȩֵ��bΪ������Ӧ��ƫ�ã�nbsvΪ����ÿ����������֧�������ĸ�����
% �������ã�ѵ������
function [xsup,w,b,nbsv]=svm_train()
clear;clc;
c=[];
addpath train1;
mapping=getmapping(8,'u2');%LBPӳ��
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
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ128*128
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  c=[c;a];%LPB��LPQ�����ں�
  disp(sprintf('���AN�����%i��ͼƬ��С��������ȡ',i));
end
%��ȡDI���������
for i=1:29    
  B=imread(strcat('train1\','DI\',num2str(i),'.jpg'));  
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ128*128
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  c=[c;a];%LPB��LPQ�����ں�
  disp(sprintf('���DI�����%i��ͼƬ��������ȡ',i));
end
%��ȡFE���������
for i=1:32
  B=imread(strcat('train1\','FE\',num2str(i),'.jpg'));  %��ȡfe���ı�����Ƭ
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);%���ղ���
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ64*64
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  c=[c;a];%LBP��LPQ�����ں�
  disp(sprintf('���FE�����%i��ͼƬ��������ȡ',i));
end
%%%����ע��һ��
%��ȡHA���������
for i=1:32    
  B=imread(strcat('train1\','HA\',num2str(i),'.jpg'));  
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ128*128
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  c=[c;a];%LPB��LPQ�����ں�
  disp(sprintf('���HA�����%i��ͼƬ��������ȡ',i));
end

%��ȡSA���������
for i=1:30    
  B=imread(strcat('train1\','SA\',num2str(i),'.jpg'));  
  X = double(B);
  X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ128*128
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  c=[c;a];%LPB��LPQ�����ں�
  disp(sprintf('���SA�����%i��ͼƬ��������ȡ',i));
end

for i=1:30
  B=imread(strcat('train1\','SU\',num2str(i),'.jpg'));
   X = double(B);
     X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ128*128
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  c=[c;a];%LPB��LPQ�����ں�
  disp(sprintf('���SU�����%i��ͼƬ��С��������ȡ',i));
end



P_train=c;
P_train=mapminmax(P_train,0,1);
%%%%%%%%������������ȡ�Ĳ���
train_label=load('train_label.txt');  %%��ȡѵ�����������

%%%%%�����￪ʼ��ʶ�������㷨��ʹ��֧����������ʶ��
addpath SVM-KM  %%���֧��������������
c = 100;
lambda = 1e-7;
kerneloption= 1.3;   %���ú˲���
kernel='gaussian'; %���ø�˹����Ϊ֧���������ĺ˺���
verbose = 0;
nbclass=6;
[xsup,w,b,nbsv]=svmmulticlassoneagainstall(P_train,train_label,nbclass,c,lambda,kernel,kerneloption,verbose); %ʹ��֧������������ѵ�����֧������
save('save.mat','xsup','w','b','nbsv');
end