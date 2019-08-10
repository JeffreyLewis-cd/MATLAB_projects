
% SPATIALGABOR - applies single oriented gabor filter to an image
%
% Usage:
% [Eim, Oim, Aim] = ?spatialgabor(im, wavelength, angle, kx, ky, showfilter)
%
% Arguments:
%im - Image to be processed.
%wavelength - Wavelength in pixels of Gabor filter to construct
%angle - Angle of filter in degrees. ?An angle of 0 gives a
%                       filter that responds to vertical features.
% kx, ky  - Scale factors specifying the filter sigma relative
%                       to the wavelength of the filter. ?This is done so
%                       that the shapes of the filters are invariant to the
%                       scale. ?kx controls the sigma in the x direction
%                       which is along the filter, and hence controls the
%                       bandwidth of the filter. ?ky controls the sigma
%                       across the filter and hence controls the
%                      orientational selectivity of the filter. A value of
%                   0.5 for both kx and ky is a good starting point.
% showfilter - An optional flag 0/1. When set an image of the
%                    even filter is displayed for inspection.
%
% Returns:
%            Eim - Result from filtering with the even (cosine) Gabor filter
%            Oim - Result from filtering with the odd (sine) Gabor filter
%            Aim - Amplitude image = sqrt(Eim.^2 + Oim.^2)
function[Eim,Oim,Aim,evenFilter] = spatialgabor(im,wavelength,angle,kx,ky,showfilter)
if nargin == 5
    showfilter = 0;
end
 
im = double(im);
[rows,cols] = size(im);
newim = zeros(rows,cols);preference
 
%构建奇数和偶数滤波器
sigmax = wavelength*kx;
sigmay = wavelength*ky;
 
sze = round(3*max(sigmax,sigmay));
[x,y] = meshgrid(-sze:sze);
evenFilter = exp(-(x.^2/sigmax^2+y.^2/sigmay^2)/2)...
.*cos(2*pi*(1/wavelength)*x);
 
oddFilter = exp(-(x.^2/sigmax^2+y.^2/sigmay^2)/2)...
.*sin(2*pi*(1/wavelength)*x);
 
evenFilter = imrotate(evenFilter,angle,'bilinear');
oddFilter = imrotate(oddFilter,angle,'bilinear');
 
%制作滤波器
Eim = filter2(evenFilter,im);
Oim = filter2(oddFilter,im);
Aim = sqrt(Eim.^2 + Oim.^2);
 
if showfilter %展示滤波器以便于检查
    figure(1),imshow(evenFilter,[]);title('filter');
end












