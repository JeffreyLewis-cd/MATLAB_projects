%函数功能：进行算法分类
% 输入
%y是目标向量，其中包含从1到nbclass的整数。
% x    : 输入数据
% xsup : 支持向量表    
% w    : 权重
% kernel : 包含内核类型的字符串
% kerneloption : 内核的设置参数
%verbose : 显示输出(默认值为0:无显示)
% 输出
% xsup	:支持向量的坐标
% w      :权重
% b		:偏移
% pos    :支持向量的位置

function [xsup,w,b,nbsv,pos,obj]=svmmulticlass(x,y,nbclass,c,epsilon,kernel,kerneloption,verbose,warmstart);

xsup=[];  %三维矩阵不能作为SV变化的量
w=[];
w=[];
b=[];
pos=[];
span=1;
qpsize=1000;
nbsv=zeros(1,nbclass);
nbsuppvector=zeros(1,nbclass);%%0 0 0
obj=0;

for i=1:nbclass
    
    yone=(y==i)+(y~=i)*-1;   %%%属于i类的设置为1 不属于i类的设置为-1;
    if exist('warmstart') & isfield(warmstart,'nbsv');
        nbsvinit=cumsum([0 warmstart.nbsv]);
        alphainit=zeros(size(yone));
        alphainit(warmstart.pos(nbsvinit(i)+1:nbsvinit(i+1)))= abs(warmstart.alpsup(nbsvinit(i)+1:nbsvinit(i+1)));
    else
        alphainit=[];
    end;
    if size(yone,1)>4000
        [xsupaux,waux,baux,posaux]=svmclassls(x,yone,c,epsilon,kernel,kerneloption,verbose,span,qpsize,alphainit);
    else
        [xsupaux,waux,baux,posaux,timeaux,alphaaux,objaux]=svmclass(x,yone,c,epsilon,kernel,kerneloption,verbose,span,alphainit);
    end;
    
    nbsv(i)=length(posaux);  %%%%nbsv 代表第i个分类器的
    xsup=[xsup;xsupaux];
    w=[w;waux];
    b=[b;baux];
    pos=[pos;posaux];
    obj=obj+objaux;
end;


