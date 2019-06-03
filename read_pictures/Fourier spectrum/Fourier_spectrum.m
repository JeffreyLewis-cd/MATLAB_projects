f=imread('Fig0316.tif');
% g=im2uint8(mat2gray(log(1+double(f))));
% imshow(g)
% imwrite(g,'Fig0305b.tif');

% g=intrans(f, 'stretch', mean2(tofloat(f)), 0.9);
% figure, imshow(g)

% g = gscale(f,'full8', 0, 1);
% figure, imshow(g);

% imhist(f, 255);

% h = imhist(f, 25);
% horz = linspace(0,255,25);
% bar(horz, h)
% axis([0 255 0 60000])
% set(gca, 'xtick', 0:50:255)
% set(gca, 'ytick', 0:20000:60000)
% xlabel('X轴数据FJiang6', 'fontsize', 12)
% ylabel('Y轴数据FJiang6','fontsize',12)
% text(20,40000,'添加文字测试FJiang6','fontsize',12)
% title('图像标题FJiang6')


% h = imhist(f,25);
% horz = linspace(0,255,25);
% stem(horz,h,'fill')
% axis([0 255 0 60000])
% set(gca, 'xtick',[0:50:255])
% set(gca,'ytick',[0:20000:60000])

% hc = imhist(f);
% plot(hc) 
% axis([0 255 0 15000])
% set(gca, 'xtick', [0:50:255])
% set(gca,'ytick',[0:2000:15000])
% ylim('auto')
% xlim('auto')

% imshow(f);
% figure,imhist(f)
% ylim('auto')
% g = histeq(f,256);
% figure, imshow(g)
% figure, imhist(g)
% ylim('auto')

% hnorm = imhist(f)./numel(f);
% cdf = cumsum(hnorm);
% x = linspace(0 ,1, 256);
% plot(x,cdf)
% axis([0 1 0 2]);
% set(gca, 'xtick', 0:.2:1)
% set(gca, 'ytick', 0:.2:1)
% xlabel('输入灰度值', 'fontsize', 9)
% ylabel('输出灰度值', 'fontsize', 9)











