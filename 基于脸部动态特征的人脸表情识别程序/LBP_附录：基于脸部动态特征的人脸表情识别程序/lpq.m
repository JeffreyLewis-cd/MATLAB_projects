% 输入参数说明：img为图片信息，winSize为窗口大小，decorr为指示是否使用反关系，freqestim为指出使用哪种方法进行局部频率估计，mode为定义输出格式
% 输出参数说明：LPQdesc为LPQ特征计算结果
% 函数作用：LPQ特征计算

function LPQdesc = lpq(img,winSize,decorr,freqestim,mode)


%% 默认参数
% 窗口大小
if nargin<2 || isempty(winSize)
    winSize=3; % 默认窗口大小3
end

% 解相关
if nargin<3 || isempty(decorr)   
    decorr=1; % 默认情况下使用的去相关
end
rho=0.90; % 采用相关系数ρ= 0.9为默认

% 局部频率估计（频率点[α，0 ]，[ 0 ]，[α，α，α]，和[α，α]）
if nargin<4 || isempty(freqestim)
    freqestim=1; %利用短时傅立叶变换（STFT）与均匀窗口默认
end
STFTalpha=1/winSize;  % 在STFT方法α（高斯衍生物α= 1）
sigmaS=(winSize-1)/4; % 对短时傅立叶变换高斯窗σ（如果freqestim = = 2）
sigmaA=8/(winSize-1); % 高斯导数的正交滤波器∑（如果freqestim = = 3）

% 输出模式
if nargin<5 || isempty(mode)
    mode='nh'; % 返回的归一化直方图作为默认
end

% 其它
convmode='valid'; %计算部分，有充分的邻居描述反应。如果使用“相同”的所有像素都包括（推断的图像零）。


%% Check inputs
if size(img,3)~=1
    error('Only gray scale image can be used as input');%唯一的灰度图像可以作为输入
end
if winSize<3 || rem(winSize,2)~=1
   error('Window size winSize must be odd number and greater than equal to 3');%winSize是奇数窗口大小大于等于3
end
if sum(decorr==[0 1])==0
    error('decorr parameter must be set to 0->no decorrelation or 1->decorrelation. See help for details.');%decorr参数必须设置为0或1 &gt; &gt;没有去相干解相关。请参阅帮助的细节
end
if sum(freqestim==[1 2 3])==0
    error('freqestim parameter must be 1, 2, or 3. See help for details.');%freqestim参数必须是1，2，或3。请参阅帮助的细节
end
if sum(strcmp(mode,{'nh','h','im'}))==0
    error('mode must be nh, h, or im. See help for details.');%模式必须NH，H，或IM。请参阅帮助的细节
end


%% Initialize
img=double(img); % 图像转换到double
r=(winSize-1)/2; % 窗口的大小半径
x=-r:r; % 窗体的空间坐标
u=1:r; % 对频率域正半形式的坐标（高斯导数需要）

%% Form 1-D filters形成1-D滤波器
if freqestim==1 % STFT均匀窗口
    %基本的STFT滤波器
    w0=(x*0+1);
    w1=exp(complex(0,-2*pi*x*STFTalpha));
    w2=conj(w1);
end


%%运行过滤器来计算在四点的频率响应。分开存储的实部和虚部
% Run first filter首先运行过滤器
filterResp=conv2(conv2(img,w0.',convmode),w1,convmode);
% 频域矩阵四频率坐标（每个频率的实部和虚部）
freqResp=zeros(size(filterResp,1),size(filterResp,2),8); 
% 存储滤波器输出
freqResp(:,:,1)=real(filterResp);
freqResp(:,:,2)=imag(filterResp);
% 对于其它频率重复的程序
filterResp=conv2(conv2(img,w1.',convmode),w0,convmode);
freqResp(:,:,3)=real(filterResp);
freqResp(:,:,4)=imag(filterResp);
filterResp=conv2(conv2(img,w1.',convmode),w1,convmode);
freqResp(:,:,5)=real(filterResp);
freqResp(:,:,6)=imag(filterResp);
filterResp=conv2(conv2(img,w1.',convmode),w2,convmode);
freqResp(:,:,7)=real(filterResp);
freqResp(:,:,8)=imag(filterResp);

% 阅读频率矩阵大小
[freqRow,freqCol,freqNum]=size(freqResp);

%% 如果去相关的应用，计算协方差矩阵和相应的白化变换
if decorr == 1
    % 计算协方差矩阵（协方差之间的像素位置x_i和x_j是Rho ^ | | x_i-x_j | |）
    [xp,yp]=meshgrid(1:winSize,1:winSize);
    pp=[xp(:) yp(:)];
    dd=dist(pp,pp');
    C=rho.^dd;
    
    % 形成二维滤波器Q1，Q2，Q3，Q4和相应的二维矩阵算子M（分离的实部和虚部）
    q1=w0.'*w1;
    q2=w1.'*w0;
    q3=w1.'*w1;
    q4=w1.'*w2;
    u1=real(q1); u2=imag(q1);
    u3=real(q2); u4=imag(q2);
    u5=real(q3); u6=imag(q3);
    u7=real(q4); u8=imag(q4);
    M=[u1(:)';u2(:)';u3(:)';u4(:)';u5(:)';u6(:)';u7(:)';u8(:)'];
    
    % 计算白化变换矩阵V
    D=M*C*M';
    A=diag([1.000007 1.000006 1.000005 1.000004 1.000003 1.000002 1.000001 1]); % Use "random" (almost unit) diagonal matrix to avoid multiple eigenvalues.使用“随机”（基本单元）以避免多个特征值对角矩阵  
    [U,S,V]=svd(A*D*A);
   
    % 重塑的频率响应
    freqResp=reshape(freqResp,[freqRow*freqCol,freqNum]);

    % 进行白化变换
    freqResp=(V.'*freqResp.').';
    
    % e撤消重塑
    freqResp=reshape(freqResp,[freqRow,freqCol,freqNum]);
end


%% 进行量化和计算LPQ码字
LPQdesc=zeros(freqRow,freqCol); % 初始化代码字（LPQ图像大小取决于是否有效或同一地区使用）
for i=1:freqNum
    LPQdesc=LPQdesc+(double(freqResp(:,:,i))>0)*(2^(i-1));
end

%% 交换格式的卡片如果LPQ编码图像所输出
if strcmp(mode,'im')
    LPQdesc=uint8(LPQdesc);
end

%% 如果所需的直方图
if strcmp(mode,'nh') || strcmp(mode,'h')
    LPQdesc=hist(LPQdesc(:),0:255);
end

%% 如果需要直方图规范
if strcmp(mode,'nh')
    LPQdesc=LPQdesc/sum(LPQdesc);
end




