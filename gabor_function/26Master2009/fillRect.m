%show the position of eyes

%method 1
im = imread('KA.AN1.39.tiff');
subplot(1,2,1)
imshow(im);
hold on;
fill([75,185,185,75,75],[120,120,140,140,120],'w','edgeColor','w','facealpha',0);


%method2
subplot(1,2,2)
imshow(uint8(im));

%left eye, 40% of eyes width
initstate = [75 120 44 20];
rectangle('Position',initstate,'LineWidth',1,'EdgeColor','r');

% distance between eyes is 20% of eyes width;

%right eye
initstate = [141 120 44 20];
rectangle('Position',initstate,'LineWidth',1,'EdgeColor','r');

text(5, 18, strcat('#eyes position'), 'Color','y', 'FontWeight','normal', 'FontSize',12);
