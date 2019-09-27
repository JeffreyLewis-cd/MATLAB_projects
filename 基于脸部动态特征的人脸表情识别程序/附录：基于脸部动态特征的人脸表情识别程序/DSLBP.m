% �������˵����imgΪͼƬ��Ϣ��mappingΪLBPӳ�䣻WΪӳ��ģ��
% �������˵����one_histΪLBP��ֱ��ͼ
% �������ã����ͼƬLBP��ֱ��ͼ
function one_hist=DSLBP(img,mapping,W)
   % mapping=getmapping(8,'u2'); 
    [result,bins] = lbp(img,2,8,mapping,'h');

    [M,N]=size(result);
    PH=7;
    PW=7;
    width=floor(M/PH);
    height=floor(N/PW);
    ah0=0;
    H0=[];
    for i=1:PH
        a0=ah0+1;
        ah0=a0+width-1;
        bh0=0;
        for j=1:PW
            b0=bh0+1;
            bh0=b0+height-1;
            if i==PH
                ah0=M;
            end
            if j==PW
               bh0=N;
            end
            

            patch=result(a0:ah0,b0:bh0);

            H0=[H0 hist(patch(:),0:(bins-1))*W(i,j)];
        end
    end
    one_hist=H0;