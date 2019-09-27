% 函数功能：识别类别
%      x  		:   输入数据
%      y  		:   输出数据
% 参数
%		c		: 拉格朗日乘数          0<a<C
%		lambda		: 调节QP优化的参数
%		kernel		: 样本类别      
%		'poly'		:多项式
%		'gaussian'	:高斯标准偏差
%       Span        : 半参数学习的矩阵

% 输出
%
% xsup	:支持向量的坐标
% w      :权重
% b		:偏移量
% pos    :支持向量位置
% alpha   :拉格朗日系数
% obj    : 价值目标函数
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

if verbose ~= 0 disp('building the distance matrix'); end;%%显示输出的话构建距离矩阵？

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
e = ones(size(y));%%n个1的 列向量

timeps = cputime - ttt;

if verbose ~= 0 disp('in QP'); end;    %%若verbose不是0 ，就显示inQP
if isinf(c)   %%%如果c是无穷大                                                        
    [alpha , lambda , pos] =  monqpCinfty(H,e,A,b,lambda,verbose,x,ps,alphainit);  
else         %%%%如果c不是无穷大                                                        
    [alpha , lambda , pos] = monqp(H,e,A,b,c,lambda,verbose,x,ps,alphainit);      %%输出的lambda和输入的lambda一样吗     
    
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
