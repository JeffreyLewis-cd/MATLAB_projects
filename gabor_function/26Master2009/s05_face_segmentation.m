im = imread('KA.HA4.32R.tiff');
seg=imcrop(im,[69,98,120,120]);
imshow(seg);
imwrite(seg,'KA.HA4.32Seg.tiff');