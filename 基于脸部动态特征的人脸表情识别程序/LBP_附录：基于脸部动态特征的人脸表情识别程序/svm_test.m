% �������˵����xsupΪ֧��������wΪ������Ӧ�ķ�������Ȩֵ��bΪ������Ӧ��ƫ�ã�nbsvΪ����ÿ����������֧�������ĸ�����ccΪֱ��ͼ���⻯
% �������˵����yyΪ�������
% �������ã��������

function ypred2=svm_test(xsup,w,b,nbsv,cc)
addpath test1;
 mapping=getmapping(8,'u2');%LBPӳ��
        W=[2,1,1,1,1,1,2; ...
          2,4,4,1,4,4,2; ...
          1,1,1,0,1,1,1; ...
          0,1,1,0,1,1,0; ...
          0,1,1,1,1,1,0; ...
          0,1,1,2,1,1,0; ...
          0,1,1,1,1,1,0]; 

% file_path =  '.\test\';% ͼ���ļ���·��  
% img_path_list = dir(strcat(file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��  
% img_num = length(img_path_list);%��ȡͼ��������  
img_num = 1;
d=[];
for i=1:img_num
%    B=imread(strcat('.\test\',num2str(i),'.jpg'));
%    B=imread(cc);
%       B=rgb2gray(B);
%     imshow(B);
    X = double(cc);
      X=255*imadjust(X/255,[0.3;1],[0;1]);
  X = imresize(X,[64 64],'bilinear');  %����'bilinear'������˫���Բ�ֵ�㷨��չΪ64*64
  H2=DSLBP(X,mapping,W);%��ȡͼƬ��LBPֱ��ͼ
  Gray=X;
  Gray=(Gray-mean(Gray(:)))/std(Gray(:))*20+128;
  lpqhist=lpq(Gray,3,1,1,'nh');       %����ÿ����Ƭlpqֱ��ͼ 
  a=[H2,lpqhist];
  d=[d;a];
%   disp(sprintf('��ɱ�����Լ���%i��ͼƬ��С��������ȡ',i));
end

P_test=d;
P_test=mapminmax(P_test,0,1);
%%%%%%%%������������ȡ�Ĳ���
% test_label=load('test_label.txt');    %%��ȡ�������������

%%%%%�����￪ʼ��ʶ�������㷨��ʹ��֧����������ʶ��
addpath SVM-KM  %%���֧��������������
c = 100;
%lambda = 1e-7;
kerneloption= 1.3;   %���ú˲���
kernel='gaussian'; %���ø�˹����Ϊ֧���������ĺ˺���
% verbose = 0;
% nbclass=3;
[ypred2,maxi] = svmmultival(P_test,xsup,w,b,nbsv,kernel,kerneloption);   %���Լ�����

disp('���Լ��ı���ʶ��Ϊ��');
for i=1:length(ypred2)
    if ypred2(i)==1  disp('����');
    elseif ypred2(i)==2    disp('���');    
    elseif ypred2(i)==3    disp('�־�');    
    elseif ypred2(i)==4    disp('����');
    elseif ypred2(i)==5    disp('����');
    elseif ypred2(i)==6    disp('����');
    end
 end
end