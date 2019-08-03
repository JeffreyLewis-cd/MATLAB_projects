clc;
clear;
close all;
%-----------------------------------
%?????????
%-----------------------------------

[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.gif'; '*.png'; '*.tiff' }, '????');
%????
if filename == 0
    return;
end

data = imread([pathname, filename]);
[m, n, z] = size(data);

pt = [50, 185];
wSize = [180,30];

des = drawRect(data,pt,wSize,5 );
subplot(1,2,1)
    imshow(data)
subplot(1,2,2)
    imshow(des)
return;
