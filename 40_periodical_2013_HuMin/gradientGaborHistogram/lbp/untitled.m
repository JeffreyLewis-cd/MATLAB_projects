im = imread('KA.AN1.39.tiff');
%基本lbp
lbp_basic_feature = lbp_basic(im);
figure(1);
imshow(lbp_basic_feature);

%2、等价模式
lbp_equi_feature = lbp_equivalent(im);
figure(2);
imshow(lbp_equi_feature);

%3、旋转不变性
lbp_rotation_feature = lbp_rotation(im);
figure(3);
imshow(lbp_rotation_feature);


%4、旋转不变性
lbp_effi_feature = efficientLBP(im);
figure(4);
imshow(lbp_effi_feature);