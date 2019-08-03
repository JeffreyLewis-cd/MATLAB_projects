function [ dest ] = drawRect( src, pt, wSize,  lineSize, color )
%???
% %??????????????????????????????????
% ????
% ?????  ?  y
% ?????  ?  x
%----------------------------------------------------------------------
%???
% src?        ?????????????????
% pt?         ?????   [x1, y1]
% wSize?   ????      [wx, wy]
% lineSize? ????
% color?     ????      [r,  g,  b] 
%----------------------------------------------------------------------
%???
% dest?           ??????
%----------------------------------------------------------------------

%flag=1: ?????
%flag=2: ?????

flag = 2;


%????????
if nargin < 5
    color = [255 255 0];
end

if nargin < 4
    lineSize = 1;
end

if nargin < 3
    disp('?????? !!!');
    return;
end





%????????
[yA, xA, z] = size(src);
x1 = pt(1);
y1 = pt(2);
wx = wSize(1);
wy = wSize(2);
if  x1>xA || ...
        y1>yA||...
        (x1+wx)>xA||...
        (y1+wy)>yA

    disp('???????? !!!');
    return;
end

%?????????????3?????
if 1==z
    dest(:, : ,1) = src;
    dest(:, : ,2) = src;
    dest(:, : ,3) = src;
else
    dest = src;
end

%?????
for c = 1 : 3                 %3????r?g?b???
    for dl = 1 : lineSize   %??????????????
        d = dl - 1;
        if  1==flag %?????
            dest(  y1-d ,            x1:(x1+wx) ,  c  ) =  color(c); %????
            dest(  y1+wy+d ,     x1:(x1+wx) , c  ) =  color(c); %????
            dest(  y1:(y1+wy) ,   x1-d ,           c  ) =  color(c); %????
            dest(  y1:(y1+wy) ,   x1+wx+d ,    c  ) =  color(c); %????
        elseif 2==flag %?????
            dest(  y1-d ,            (x1-d):(x1+wx+d) ,  c  ) =  color(c); %????
            dest(  y1+wy+d ,    (x1-d):(x1+wx+d) ,  c  ) =  color(c); %????
            dest(  (y1-d):(y1+wy+d) ,   x1-d ,           c  ) =  color(c); %????
            dest(  (y1-d):(y1+wy+d) ,   x1+wx+d ,    c  ) =  color(c); %????
        end
    end    
end %????


end %???
