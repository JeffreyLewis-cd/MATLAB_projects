%%%%%%%%%%%%%%%%%%
% RGB=imread('fish01.jpg');
% figure(1),imshow(RGB),title('fish01_color');
% I=rgb2gray(RGB);
% figure(2),imshow(I),title('fish01_gray');
% imwrite(I,'fish01_grb2gray.jpg')

<<<<<<< HEAD
% positive_fish=imread('fish01_grb2gray.jpg');
% negative_fish=255 - positive_fish;
% figure(1),imshow(negative_fish);
% imwrite(negative_fish,'fish01_negative.jpg');

f=imread('fish01_original.jpg');
%  g2=imadjust(f,[0.5 0.75],[0 1]);
%  figure(1),imshow(g2);
%  imwrite(g2,'fish01_0.5-0.75.jpg');


% g3=imadjust(f,[ ], [ ], 2);
% imwrite(g3,'fish01_gamma_2.jpg');

% g=imadjust(f,stretchlim(f),[ ]);
% figure(1),imshow(g);
% imwrite(g,'fish01_stretchlim[].jpg');

% g=imadjust(f,stretchlim(f),[1 0]);
% figure(1),imshow(g);
% imwrite(g,'fish01_stretchlim[1 0].jpg');


gs=im2uint8(mat2gray(f));
figure(1),imshow(gs);


=======
positive_fish=imread('fish01_grb2gray.jpg');
negative_fish=255 - positive_fish;
figure(1),imshow(negative_fish);
imwrite(negative_fish,'fish01_negative.jpg');
>>>>>>> 8496a2e17186e030710bb4e8328ba477f66a36f3
