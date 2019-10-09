% �������ܣ�ʶ�����
%      x  		:   ��������
%      y  		:   �������
% ����
%		c		: �������ճ���          0<a<C
%		lambda		: ����QP�Ż��Ĳ���
%		kernel		: �������      
%		'poly'		:����ʽ
%		'gaussian'	:��˹��׼ƫ��
%       Span        : �����ѧϰ�ľ���

% ���
%
% xsup	:֧������������
% w      :Ȩ��
% b		:ƫ����
% pos    :֧������λ��
% alpha   :��������ϵ��
% obj    : ��ֵĿ�꺯��
function [xsup,w,d,pos,timeps,alpha,obj]=svmclass(x,y,c,lambda,kernel,kerneloption,verbose,span, alphainit)

if nargin< 9
    alphainit=[];
end;

if nargin < 8 | isempty(span)
    A = y;
    b = 0;
else
    if span==1
        span=ones(size(y));
    end;
    [na,m]=size(span);
    [n un] = size(y);
    if n ~= na
        error('span, x and y  must have the same number of row')
    end
    A = (y*ones(1,m)).*span;
    b = zeros(m,1);
end
if nargin < 7
    verbose = 0;
end

if nargin < 6
    gamma = 1;
end

if nargin < 5
    kernel = 'gaussian';
end

if nargin < 4
    lambda = 0.000000001;
end

if nargin < 3
    c = inf;
end


[n un] = size(y);

if ~isempty(x)
    [nl nc] = size(x);
    if n ~= nl
        error('x and y must have the same number of row')
    end
end;

if min(y) ~= -1
    error(' y must coded: 1 for class one and -1 for class two')
end

if verbose ~= 0 disp('building the distance matrix'); end;%%��ʾ����Ļ������������

ttt = cputime;

ps  =  zeros(n,n);		
ps=svmkernel(x,kernel,kerneloption);


%----------------------------------------------------------------------
%      monqp(H,b,c) solves the quadratic programming problem:
% 
%    min 0.5*x'Hx - d'x   subject to:  A'x = b  and  0 <= x <= c 
%     x    
%----------------------------------------------------------------------
H =ps.*(y*y'); 
e = ones(size(y));%%n��1�� ������

timeps = cputime - ttt;

if verbose ~= 0 disp('in QP'); end;    %%��verbose����0 ������ʾinQP
if isinf(c)   %%%���c�������                                                        
    [alpha , lambda , pos] =  monqpCinfty(H,e,A,b,lambda,verbose,x,ps,alphainit);  
else         %%%%���c���������                                                        
    [alpha , lambda , pos] = monqp(H,e,A,b,c,lambda,verbose,x,ps,alphainit);      %%�����lambda�������lambdaһ����     
    
end
if verbose ~= 0 disp('out QP'); end;

alphaall=zeros(size(e));   
alphaall(pos)=alpha;
obj=-0.5*alphaall'*H*alphaall +e'*alphaall;

if ~isempty(x)
    xsup = x(pos,:);
else
    xsup=[];
end;

ysup = y(pos);



w = (alpha.*ysup);
d = lambda;

if verbose ~= 0  
    disp('max(alpha)') 
    fprintf(1,'%6.2f\n',max(alpha)) 
end 
