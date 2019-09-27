%函数功能：该例程使用支持向量机对训练集进行分类，利用二次规划算法(主动约束法)
% 输入
%      x  		: 输入数据
%      y  		: 输出数据
% 参数
%		c		: 拉格朗日乘数   
%		lambda		: 调节QP优化的参数
%		kernel		: 样本类别
%		'poly'		:多项式
%		'gaussian'	:高斯标准偏差
%		kerneloption : 内核参数
% 		verbose : 显示输出(默认值为0:无显示)
%       alphainit : QP问题的初始化向量
%
% 输出
% xsup	:支持向量的坐标
% w      :权重
% b		:偏移
% pos    :支持向量的位置
% alpha  :Lagragian 乘数
function [xsup,w,b,nbsv,pos,alpha]=svmmulticlass(x,y,nbclass,C,epsilon,kernel,kerneloption,verbose, alphainit)

if nargin< 7
    alphainit=[];
end;


if nargin < 6
    verbose = 0;
end

if nargin < 5
    kerneloption = 1;
end

if nargin < 4
    kernel = 'gaussian';
end

if nargin < 3
    lambda = 0.000000001;
end

if nargin < 2
    C = 100000;
end

%------------------------------------------------------
% initialisation
%-------------------------------------------------------
[y,ind]=sort(y);
x=x(ind,:);

yextended=repmat(y,nbclass,1);
xextended=repmat(x,nbclass,1);


ell=size(x,1);
n=sum(y==1);

if size(C,1)==1
    C=C*ones(size(y));
end;

%------------------------------------------------------
% construction des matrices associ?au pb QP
%-------------------------------------------------------


MatAux=zeros(ell,ell);
MatAuxQ3=zeros(ell,ell);
Q21=zeros(ell*nbclass,ell*nbclass);
Q22=zeros(ell*nbclass,ell*nbclass);
debut=1;
debutQ3=1;
for s=1:nbclass
    indclass=find(y==s);
    ellinclass=length(indclass);
    MatAux(debut:debut+ellinclass-1,debut:debut+ellinclass-1)=svmkernel(x(indclass,:),kernel,kerneloption);
    debut=debut+ellinclass;
    
    MatAuxQ3(debutQ3:debutQ3+ell-1,debutQ3:debutQ3+ell-1)=svmkernel(x,kernel,kerneloption);
    debutQ3=debutQ3+ell;   
    for j=1:ell
        Kij=svmkernel(x,kernel,kerneloption,x(j,:));
        yj=y(j);
        Q21( (yj-1)*ell +1: yj *ell, (s-1)*ell + j )= -Kij; 
        
        ind=find(yextended==s);
        Q22(ind,(s-1)*ell + j )= - svmkernel(xextended(ind,:),kernel,kerneloption,x(j,:));
        
    end;
end;

Q1=repmat(MatAux,nbclass,nbclass);
Q3=MatAuxQ3;
Q2=Q21+Q22;

Q=Q1+Q2+Q3;


%------------------------------------------------------
% Les contraintes
%-------------------------------------------------------



yii=[];
Am=zeros(nbclass, size(yextended,1));
Am1=zeros(nbclass, size(yextended,1));
for s=1:nbclass
    ind=(s-1)*ell+1: s*ell;
    Am(s,ind)=ones(1,length(ind));
    ind1=find(yextended==s);
    Am1(s,ind1)=ones(1,length(ind1));
    yii= [yii;y==s];
end;

A=Am-Am1;

c=2*ones(size(yextended));
b=zeros(size(A,1),1);
Cvect=repmat(C,3,1);
unused=find(yii==1);
Cvect(unused)=0.00000*ones(length(unused),1);




xinit=zeros(size(Cvect));
xinit(n+1)=Cvect(n+1)/2;
[xnew, lambda, pos] = monqp(Q,c,A',b,Cvect,epsilon,verbose,x,[],xinit);


b=-lambda;
alpha=zeros(size(Cvect));
alpha(pos)=xnew;
w=zeros(size(xextended,1),1);
xsup=[];


for s=1:nbclass
    for i=1:ell
        if y(i)==s
            for m=1:nbclass
                w((s-1)*ell+i)=w((s-1)*ell+i)+alpha((m-1)*ell+i);
            end;
        end;
        w((s-1)*ell+i)=w((s-1)*ell+i)-alpha((s-1)*ell+i);
    end;
end;

waux=[];
for s=1:nbclass
    ind=find(w((s-1)*ell+1:(s-1)*ell+ell)~=0);
    waux=[waux;w( (s-1)*ell+ ind)];
    nbsv(s)=length(ind);
    xsup=[xsup; x(ind,:)]; 
end;
w=waux;