im = imread('KA.HA4.32Seg.tiff');
pic2=imresize(im,[128,128]);
imshow(pic2);
imwrite(pic2,'KA.HA4.32Resize.tiff');
