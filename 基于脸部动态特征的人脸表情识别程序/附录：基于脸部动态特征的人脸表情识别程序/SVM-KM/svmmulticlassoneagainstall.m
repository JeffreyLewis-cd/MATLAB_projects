%�������ܣ������㷨����
% ����
%y��Ŀ�����������а�����1��nbclass��������
% x    : ��������
% xsup : ֧��������    
% w    : Ȩ��
% kernel : �����ں����͵��ַ���
% kerneloption : �ں˵����ò���
%verbose : ��ʾ���(Ĭ��ֵΪ0:����ʾ)
% ���
% xsup	:֧������������
% w      :Ȩ��
% b		:ƫ��
% pos    :֧��������λ��

function [xsup,w,b,nbsv,pos,obj]=svmmulticlass(x,y,nbclass,c,epsilon,kernel,kerneloption,verbose,warmstart);

xsup=[];  %��ά��������ΪSV�仯����
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
    
    yone=(y==i)+(y~=i)*-1;   %%%����i�������Ϊ1 ������i�������Ϊ-1;
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
    
    nbsv(i)=length(posaux);  %%%%nbsv �����i����������
    xsup=[xsup;xsupaux];
    w=[w;waux];
    b=[b;baux];
    pos=[pos;posaux];
    obj=obj+objaux;
end;


