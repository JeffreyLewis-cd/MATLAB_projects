% �������˵����imgΪͼƬ��Ϣ��winSizeΪ���ڴ�С��decorrΪָʾ�Ƿ�ʹ�÷���ϵ��freqestimΪָ��ʹ�����ַ������оֲ�Ƶ�ʹ��ƣ�modeΪ���������ʽ
% �������˵����LPQdescΪLPQ����������
% �������ã�LPQ��������

function LPQdesc = lpq(img,winSize,decorr,freqestim,mode)


%% Ĭ�ϲ���
% ���ڴ�С
if nargin<2 || isempty(winSize)
    winSize=3; % Ĭ�ϴ��ڴ�С3
end

% �����
if nargin<3 || isempty(decorr)   
    decorr=1; % Ĭ�������ʹ�õ�ȥ���
end
rho=0.90; % �������ϵ����= 0.9ΪĬ��

% �ֲ�Ƶ�ʹ��ƣ�Ƶ�ʵ�[����0 ]��[ 0 ]��[����������]����[������]��
if nargin<4 || isempty(freqestim)
    freqestim=1; %���ö�ʱ����Ҷ�任��STFT������ȴ���Ĭ��
end
STFTalpha=1/winSize;  % ��STFT����������˹�������= 1��
sigmaS=(winSize-1)/4; % �Զ�ʱ����Ҷ�任��˹���ң����freqestim = = 2��
sigmaA=8/(winSize-1); % ��˹�����������˲����ƣ����freqestim = = 3��

% ���ģʽ
if nargin<5 || isempty(mode)
    mode='nh'; % ���صĹ�һ��ֱ��ͼ��ΪĬ��
end

% ����
convmode='valid'; %���㲿�֣��г�ֵ��ھ�������Ӧ�����ʹ�á���ͬ�����������ض��������ƶϵ�ͼ���㣩��


%% Check inputs
if size(img,3)~=1
    error('Only gray scale image can be used as input');%Ψһ�ĻҶ�ͼ�������Ϊ����
end
if winSize<3 || rem(winSize,2)~=1
   error('Window size winSize must be odd number and greater than equal to 3');%winSize���������ڴ�С���ڵ���3
end
if sum(decorr==[0 1])==0
    error('decorr parameter must be set to 0->no decorrelation or 1->decorrelation. See help for details.');%decorr������������Ϊ0��1 &gt; &gt;û��ȥ��ɽ���ء�����İ�����ϸ��
end
if sum(freqestim==[1 2 3])==0
    error('freqestim parameter must be 1, 2, or 3. See help for details.');%freqestim����������1��2����3������İ�����ϸ��
end
if sum(strcmp(mode,{'nh','h','im'}))==0
    error('mode must be nh, h, or im. See help for details.');%ģʽ����NH��H����IM������İ�����ϸ��
end


%% Initialize
img=double(img); % ͼ��ת����double
r=(winSize-1)/2; % ���ڵĴ�С�뾶
x=-r:r; % ����Ŀռ�����
u=1:r; % ��Ƶ����������ʽ�����꣨��˹������Ҫ��

%% Form 1-D filters�γ�1-D�˲���
if freqestim==1 % STFT���ȴ���
    %������STFT�˲���
    w0=(x*0+1);
    w1=exp(complex(0,-2*pi*x*STFTalpha));
    w2=conj(w1);
end


%%���й��������������ĵ��Ƶ����Ӧ���ֿ��洢��ʵ�����鲿
% Run first filter�������й�����
filterResp=conv2(conv2(img,w0.',convmode),w1,convmode);
% Ƶ�������Ƶ�����꣨ÿ��Ƶ�ʵ�ʵ�����鲿��
freqResp=zeros(size(filterResp,1),size(filterResp,2),8); 
% �洢�˲������
freqResp(:,:,1)=real(filterResp);
freqResp(:,:,2)=imag(filterResp);
% ��������Ƶ���ظ��ĳ���
filterResp=conv2(conv2(img,w1.',convmode),w0,convmode);
freqResp(:,:,3)=real(filterResp);
freqResp(:,:,4)=imag(filterResp);
filterResp=conv2(conv2(img,w1.',convmode),w1,convmode);
freqResp(:,:,5)=real(filterResp);
freqResp(:,:,6)=imag(filterResp);
filterResp=conv2(conv2(img,w1.',convmode),w2,convmode);
freqResp(:,:,7)=real(filterResp);
freqResp(:,:,8)=imag(filterResp);

% �Ķ�Ƶ�ʾ����С
[freqRow,freqCol,freqNum]=size(freqResp);

%% ���ȥ��ص�Ӧ�ã�����Э����������Ӧ�İ׻��任
if decorr == 1
    % ����Э�������Э����֮�������λ��x_i��x_j��Rho ^ | | x_i-x_j | |��
    [xp,yp]=meshgrid(1:winSize,1:winSize);
    pp=[xp(:) yp(:)];
    dd=dist(pp,pp');
    C=rho.^dd;
    
    % �γɶ�ά�˲���Q1��Q2��Q3��Q4����Ӧ�Ķ�ά��������M�������ʵ�����鲿��
    q1=w0.'*w1;
    q2=w1.'*w0;
    q3=w1.'*w1;
    q4=w1.'*w2;
    u1=real(q1); u2=imag(q1);
    u3=real(q2); u4=imag(q2);
    u5=real(q3); u6=imag(q3);
    u7=real(q4); u8=imag(q4);
    M=[u1(:)';u2(:)';u3(:)';u4(:)';u5(:)';u6(:)';u7(:)';u8(:)'];
    
    % ����׻��任����V
    D=M*C*M';
    A=diag([1.000007 1.000006 1.000005 1.000004 1.000003 1.000002 1.000001 1]); % Use "random" (almost unit) diagonal matrix to avoid multiple eigenvalues.ʹ�á��������������Ԫ���Ա���������ֵ�ԽǾ���  
    [U,S,V]=svd(A*D*A);
   
    % ���ܵ�Ƶ����Ӧ
    freqResp=reshape(freqResp,[freqRow*freqCol,freqNum]);

    % ���а׻��任
    freqResp=(V.'*freqResp.').';
    
    % e��������
    freqResp=reshape(freqResp,[freqRow,freqCol,freqNum]);
end


%% ���������ͼ���LPQ����
LPQdesc=zeros(freqRow,freqCol); % ��ʼ�������֣�LPQͼ���Сȡ�����Ƿ���Ч��ͬһ����ʹ�ã�
for i=1:freqNum
    LPQdesc=LPQdesc+(double(freqResp(:,:,i))>0)*(2^(i-1));
end

%% ������ʽ�Ŀ�Ƭ���LPQ����ͼ�������
if strcmp(mode,'im')
    LPQdesc=uint8(LPQdesc);
end

%% ��������ֱ��ͼ
if strcmp(mode,'nh') || strcmp(mode,'h')
    LPQdesc=hist(LPQdesc(:),0:255);
end

%% �����Ҫֱ��ͼ�淶
if strcmp(mode,'nh')
    LPQdesc=LPQdesc/sum(LPQdesc);
end




