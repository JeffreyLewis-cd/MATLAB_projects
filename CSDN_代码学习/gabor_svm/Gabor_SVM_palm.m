function [output]=Gabor_SVM_palm(imagein)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function is used to create gaborpalms and then gained the
% sub-block's mean and std
% wenchangzhi 2006/10/27
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear,close all;

A=[];
scale=5;  %  denote the scale of the gabor wavelet
orientation=4;  % denote the orientation of the gabor wavelet
kmax=pi/2;   % the highest frequency with the smallest kernel size
sigma=pi*2;  % the parameter :theta 
mask_size=128;  % for every kernel the size is 128*128% this is the size of Gabor mask
f=sqrt(2);   % f is the spacing factor
sig=sigma*sigma; % the squre of theta
offset=mask_size/2; 
% imagein=imread('Palm_S120_1.bmp');
imagein=double(imagein);
M=[];
S=[];
for v=0:(scale-1)
    for u=0:(orientation-1)
        kv=kmax/f^v;
        phiu=u*pi/4;
        kv_mag=kv*kv;
        gabor_kel=zeros(128,128);        
            for x=0:(mask_size-1)                  
                for y=0:(mask_size-1)                
                    i=x-offset;                
                    j=y-offset;                
                    mag=i*i+j*j;                
                    gabor_kel(x+1,y+1)=kv_mag/sig*exp(-0.5*kv_mag*mag/sig)*(exp(sqrt(-1)*kv*(i*cos(phiu)+j*sin(phiu))-exp(-1.0*sig/2.0)));                   
                end           %the gabor kernel      
            end    
              result=abs(fftshift(ifft2((fft2(imagein)).*fft2(gabor_kel))));    % ������ͼ�������õ�Gabopam    
              % �����õľ�����зֿ飬�ֱ����ÿһ��ľ�ֵ�ͷ���
              MM=[];
              SS=[];
              temp=zeros(64,64);
              for  ii=1:64:65
                  for jj=1:64:65     %������ֳ�2*2 ��
                      temp=result(ii:(ii+63),jj:(jj+63));
                      mm=mean(temp(1:64*64));
                      ss=std(temp(1:64*64));
                      MM=[MM mm];
                      SS=[SS ss];
                  end
             end
         M=[M  MM];
         S=[S  SS];
     end
 end  

output=[M S];% �õ������������ĳ���Ϊ5*4*4*2=160


