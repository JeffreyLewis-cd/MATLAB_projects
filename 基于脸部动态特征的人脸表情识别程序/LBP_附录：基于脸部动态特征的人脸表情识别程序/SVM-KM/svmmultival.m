function [ypred,maxi,ypredMat]=svmmultival(x,xsup,w,b,nbsv,kernel,kerneloption)

[n1,n2]=size(x);
nbclass=length(nbsv);   %%�����Ŀ nbsv ����ÿ����������֧�������ĸ���
y=zeros(n1,nbclass);    %%����������Ŀ
nbsv=[0 nbsv];         
aux=cumsum(nbsv);    %cumsum�����������ۼӺ� ��A=[0 1 2 3]�� ��cumsum����� cumsum(A)=[0 1 3 6]; ��һ������0 �ڶ������ǵ�һ��������֧�������� ��������1+2�� ���ĸ����ܵ�֧����������Ŀ


for i=1:nbclass
    if ~isempty(xsup) %%�������xsup֧������
         xsupaux=xsup(aux(i)+1:aux(i)+nbsv(i+1),:);%%����22��aux��һ�������洢֧��������Ŀ���ۼӣ�����ǲ�����Ӧ�ķ�������֧������
        % 
        waux=w(aux(i)+1:aux(i)+nbsv(i+1)); %%������Ӧ�ķ�������Ȩֵ
        baux=b(i);  %������Ӧ��ƫ��
        ypred(:,i)= svmval(x,xsupaux,waux,baux,kernel,kerneloption);  %%ѵ���ӷ�����
    else
      if isempty(x)  %  Kernel matrix is given as a parameter ������x��ִ��
        waux=w(aux(i)+1:aux(i)+nbsv(i+1));
        baux=b(i);
        kernel='numerical';
        xsupaux=[];
        pos=aux(i)+1:aux(i)+nbsv(i+1);
        kerneloption2.matrix=kerneloption.matrix(:,pos);
        ypred(:,i)= svmval(x,xsupaux,waux,baux,kernel,kerneloption2);   %%��������һ��x=1,2 ��ôyҲ��һ�� 0,1 2 ȡ���ֵΪ���
      end;
    end;
   
end;
ypredMat=ypred;
[maxi,ypred]=max(ypred');
maxi=maxi';
ypred=ypred';
