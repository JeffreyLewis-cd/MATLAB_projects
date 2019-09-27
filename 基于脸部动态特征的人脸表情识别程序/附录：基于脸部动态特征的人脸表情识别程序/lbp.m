% 输入参数说明：varargin为矩阵包含图片信息，映射半径，映射计算采样点数，LBP映射和直方图
% 输出参数说明：[result,bins]为LBP特征计算结果
% 函数作用：LBP特征计算
function [result,bins] = lbp(varargin) 

error(nargchk(1,5,nargin));

image=varargin{1};
d_image=double(image);

if nargin==1
    spoints=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
    mapping=0;
    mode='h';
end

if (nargin == 2) && (length(varargin{2}) == 1)
    error('Input arguments');
end

if (nargin > 2) && (length(varargin{2}) == 1)
    radius=varargin{2};
    neighbors=varargin{3};
    
    spoints=zeros(neighbors,2);

    % Angle step.
    a = 2*pi/neighbors;
    
    for i = 1:neighbors
        spoints(i,1) = -radius*sin((i-1)*a);
        spoints(i,2) = radius*cos((i-1)*a);
    end
    
    if(nargin >= 4)
        mapping=varargin{4};
    else
        mapping=0;
    end
    
    if(nargin >= 5)
        mode=varargin{5};
    else
        mode='h';
    end
end

if (nargin > 1) && (length(varargin{2}) > 1)
    spoints=varargin{2};
    
    if(nargin >= 3)
        mapping=varargin{3};
    else
        mapping=0;
    end
    
    if(nargin >= 4)
        mode=varargin{4};
    else
        mode='h';
    end   
end

% 确定输入图像的尺寸
[ysize xsize] = size(image);

neighbors=size(spoints,1);

miny=min(spoints(:,1));
maxy=max(spoints(:,1));
minx=min(spoints(:,2));
maxx=max(spoints(:,2));

% 块大小，每个LBP代码在大小为bsizey*bsizex的块中计算
bsizey=ceil(max(maxy,0))-floor(min(miny,0))+1;
bsizex=ceil(max(maxx,0))-floor(min(minx,0))+1;

% 块中的原点坐标(0,0)
origy=1-floor(min(miny,0));
origx=1-floor(min(minx,0));

% 输入图像的最小允许大小取决于使用的LBP操作符的半径。
if(xsize < bsizex || ysize < bsizey)
  error('Too small input image. Should be at least (2*radius+1) x (2*radius+1)');
end

% 计算 dx 和 dy;
dx = xsize - bsizex;
dy = ysize - bsizey;

% 填充中心像素矩阵C。
C = image(origy:origy+dy,origx:origx+dx);
d_C = double(C);

bins = 2^neighbors;

%用0初始化结果矩阵。
result=zeros(dy+1,dx+1);

%计算LBP代码图像

for i = 1:neighbors
  y = spoints(i,1)+origy;
  x = spoints(i,2)+origx;
  % 计算x和y的楼层、线圈和圆数。
  fy = floor(y); cy = ceil(y); ry = round(y);
  fx = floor(x); cx = ceil(x); rx = round(x);
  % 检查是否需要插值。
  if (abs(x - rx) < 1e-6) && (abs(y - ry) < 1e-6)
    % 不需要插值，使用原始数据类型
    N = image(ry:ry+dy,rx:rx+dx);
    D = N >= C; 
  else
    % 需要插值，使用双类型图像 
    ty = y - fy;
    tx = x - fx;

    % 计算插值权值。
    w1 = (1 - tx) * (1 - ty);
    w2 =      tx  * (1 - ty);
    w3 = (1 - tx) *      ty ;
    w4 =      tx  *      ty ;
    % 计算插值像素值
    N = w1*d_image(fy:fy+dy,fx:fx+dx) + w2*d_image(fy:fy+dy,cx:cx+dx) + ...
        w3*d_image(cy:cy+dy,fx:fx+dx) + w4*d_image(cy:cy+dy,cx:cx+dx);
    D = N >= d_C; 
  end  
  % 更新结果矩阵。
  v = 2^(i-1);
  result = result + v*D;
end

if length(mapping) > 1
    bins = max(max(mapping)) + 1;
    for i = 1:size(result,1)
        for j = 1:size(result,2)
            result(i,j) = mapping(result(i,j)+1);
        end
    end
end






