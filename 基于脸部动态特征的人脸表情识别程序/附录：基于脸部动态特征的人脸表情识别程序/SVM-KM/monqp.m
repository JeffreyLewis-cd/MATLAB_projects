% 函数功能为投影关联
function [xnew, lambda, pos,mu] = monqp(H,c,A,b,C,l,verbose,X,ps,xinit)



%-------------------------------------------------------------------------- 
%                                verifications 
%-------------------------------------------------------------------------- 
[n,d] = size(H); 
[nl,nc] = size(c); 
[nlc,ncc] = size(A); 
[nlb,ncb] = size(b); 
if d ~= n 
    error('H must be a squre matrix n by n'); 
end 
if nl ~= n 
    error('H and c must have the same number of row'); 
end 

if nlc ~= n 
    error('H and A must have the same number of row'); 
end 
if nc ~= 1 
    error('c must be a row vector'); 
end 
if ncb ~= 1 
    error('b must be a row vector'); 
end 
if ncc ~= nlb  
    error('A'' and b  must have the same number of row'); 
end 

if nargin < 5		% 正则化参数的默认值
    l = 0;				 
end; 

if nargin < 6		% 显示参数的默认值 
    verbose = 0;				 
end; 
if  size(C,1)~=nl
    %   keyboard
    C=ones(nl,1)*C;  % 向量化上界约束
end;
if exist('xinit','var')~=1
    xinit=[];
end;


fid = 1; %默认值，当前matlab窗口
%-------------------------------------------------------------------------- 


%-------------------------------------------------------------------------- 
%                       I N I T I A L I S A T I O N  
%-------------------------------------------------------------------------- 

OO = zeros(ncc);
H = H+l*eye(length(H)); % 先决条件

xnew = -1*ones(size(C));ness = 0;     
ind=1;



if isempty(xinit)
    
    while (( sum (xnew < 0)) >0 | ( sum(xnew >C(ind)) > 0))  & ness < 100  
        ind = randperm(n);
        ind = sort(ind(1:ncc)');
        aux=[H(ind,ind) A(ind,:);A(ind,:)' OO];
        aux= aux+l*eye(size(aux));
        if rcond(aux)>1e-12
            newsol = aux\[c(ind) ; b];
            xnew = newsol(1:length(ind));
            ness = ness+1; 
        else
            ness=101;
            break;
        end;
    end;
    %keyboard
    if ness < 100
        x = xnew;
        lambda = newsol(length(ind)+1:length(ind)+ncc);
    else
        % Brute Force Initialisation
       
        ind = [1];
        x = C(ind)/2.*ones(size(ind,1),1);                            
        lambda=ones(ncc,1);    
        
   
        
        
    end
    indsuptot = [];	 
else  % 从预定义的x开始
    
    
    indsuptot=find(xinit==C);
    indsup=indsuptot;
    ind=find(xinit>0 & xinit ~=C) ;
    x = xinit(ind);
    lambda=ones(ncc,1);
    
end;



% 修改QP，不受等式约束
if sum(A==0)
    ncc=0;
end;


[U,testchol] = chol(H); % Test definite positiveness of H
firstchol=1;

%-------------------------------------------------------------------------- 
%                            M A I N   L O O P 
%-------------------------------------------------------------------------- 

Jold = 10000000000000000000;  
%C = Jold; % 对于成本函数
if verbose ~= 0 
    disp('      Cost     Delta Cost  #support  #up saturate'); 
    nbverbose = 0; 
end 

nbiter=0;
STOP = 0;
nbitermax=20*n;
while STOP ~= 1
    
    nbiter=nbiter+1;
    indd = zeros(n,1);indd(ind)=ind;nsup=length(ind);indd(indsuptot)=-1;
    if verbose ~= 0 
        
            [J,yx] = cout(H,x,b,C,indd,c,A,b,lambda); 

        nbverbose = nbverbose+1; 
        if nbverbose == 20 
            disp('      Cost     Delta Cost  #support  #up saturate'); 
            nbverbose = 0; 
        end 
        if Jold == 0 
            fprintf(fid,'| %11.4e | %8.4f | %6.0f | %6.0f |\n',[J (Jold-J) nsup length(indsuptot)]); 
        elseif  (Jold-J)>0
            fprintf(fid,'| %11.4e | %8.4f | %6.0f | %6.0f |\n',[J min((Jold-J)/abs(Jold),99.9999) nsup length(indsuptot)]); 
        else
            fprintf(fid,'| %11.4e | %8.4f | %6.0f | %6.0f | bad mouve \n',[J max((Jold-J)/abs(Jold),-99.9999) nsup length(indsuptot)]); 
            
        end 
            Jold = J; 

    end 
    
    
    
    

    
    ce = c(ind);
    be = b;
    

    

    if (isempty(indsuptot)==0) % if NOT empty
        

        
        Cmat= ones(length(ind),1)*(C(indsuptot)'); 
        if size(ce)~= size(sum( Cmat.*H(ind,indsuptot),2))
            keyboard;
        end;
        ce= ce - sum( Cmat.*H(ind,indsuptot),2);%                              min     x'Hx + c'x
        Cmat= C(indsuptot)*ones(1,size(A,2)); 
        be= be - sum(Cmat.*A(indsuptot,:),1)';                            %    with    Ax=b
        
    end 
    

    At=A(ind,:)';
    Ae=A(ind,:);
    
    
    if testchol==0
        auxH=H(ind,ind);
        [U,testchol] = chol(auxH); % It would be better to use an updated choleski
        %------------------------------------------------------------------
%         if length(ind)>5
%             keyboard
%         if firstchol   
%             Ub=chol(auxH)'; 
%             firstchol=0;
%         else
%             
%             if directioncholupdate==1
%                 Ubr = updatechol(Ub,indexcholupdate-1,H(varcholupdate,:),directioncholupdate);
%             else
%                 Ubr = updatechol(Ub,indexcholupdate,[],directioncholupdate);
%             end;
%            
%             max(max(abs(Ub-U)))
%         end;
%     end
        %------------------------------------------------------------------

        M = At*(U\(U'\Ae));
        d = U\(U'\ce);
        d = (At*d - be);   % second membre  (homage au gars OlgaZZZZZZ qui nous a bien aid锟?
        % On appelle le gc fabuleux de mister OlgaZZZ Hoduc
        % lambdastart = rand([m,1]);
        % [lambda] = gradconj(lambdastart,M*M,M*d,MaxIterZZZ,tol,1000);
        if rcond(M)<l
            M=M+l*eye(size(M));
        end;
        lambda = M\d;
  
        xnew=auxH\(ce-Ae*lambda);
    else
        
        % if non definite positive;
        auxH=H(ind,ind);
        
        auxM=At*(auxH\Ae);
        M=auxM'*auxM;
        d=auxH\ce;
        d=At*d-be;
        if rcond(M)<l
            M=M+l*eye(size(M));
        end;
        lambda=M\d;
        xnew=auxH\(ce-Ae*lambda);
    end;
    
    %-------------------------------------------------------------------------------------------------------
    
    [minxnew minpos]=min(xnew);
    
    
    if (sum(xnew< 0) > 0 | sum(xnew > C(ind)) > 0)   &  length(ind) > ncc  

        %-------------------------------------------------------------------------
        d = (xnew - x)+l;                % 投影方向
        indad = find(xnew < 0); 
        indsup = find(xnew > C(ind) );                  
        [tI indmin] = min(-x(indad)./d(indad));
        [tS indS] = min((C(ind(indsup))-x(indsup))./d(indsup)); 
        if isempty(tI) , tI = tS + 1; end; 
        if isempty(tS) , tS = tI + 1; end; 
        t = min(tI,tS); 
        
        x = x + t*d;                 % 投影到可容许集
        
        if t == tI 
            
            varcholupdate=ind(indad(indmin));
            indexcholupdate=indad(indmin);
            directioncholupdate=-1; % remove
            
            ind(indad(indmin)) = [];            % 关联变量被设置为0
            x(indad(indmin)) = [];              % 关联变量被设置为0
            
            
            
        else
            indexcholupdate=indsup(indS);
            varcholupdate=ind(indsup(indS));
            directioncholupdate=-1; % remove
            
            indsuptot = [indsuptot ; ind(indsup(indS))]; 
            ind(indsup(indS))= []; 
            x(indsup(indS))= []; 
            
            
            
        end
        
    else
        xt = zeros(n,1);           % keyboard;
        xt(ind) = xnew;              % keyboard;
        xt(indsuptot) = C(indsuptot); indold=ind;             % keyboard;                                
        mu = H*xt - c + A*lambda;    
        
        indsat = 1:n;                          
        indsat([ind ; indsuptot]) = [];
        
        [mm mpos]=min(mu(indsat));
        [mmS mposS]=min(-mu(indsuptot));  %keyboard
        
        if ((~isempty(mm) & (mm < -sqrt(eps)))  | (~isempty(mmS) & (mmS <  -sqrt(eps)))) & nbiter< nbitermax
            if isempty(indsuptot) | (mm < mmS)             % il faut rajouter une variable
                ind = sort([ind ; indsat(mpos)]);        % on elimine une contrainte de type x=0
                x = xt(ind);
                indexcholupdate=find(ind==indsat(mpos));
                varcholupdate=indsat(mpos);
                directioncholupdate=1; % remove
            else
                ind = sort([ind ; indsuptot(mposS)]);  % on elimine la contrainte sup si necessaire
                x = xt(ind);                           % on elimine une contrainte de type x=C
                indexcholupdate=find(ind==indsuptot(mposS));
                varcholupdate=indsuptot(mposS);
                indsuptot(mposS)=[];
                directioncholupdate=1; % remove
            end
        else
            
            STOP = 1;                
            pos=sort([ind ; indsuptot]);
            xt = zeros(n,1);             
            xt(ind) = xnew;              
            xt(indsuptot) = C(indsuptot);          
            indout = 1:n;
            indout(pos)=[];
            xnew = xt;
            xnew(indout)=[];
            
        end
        
    end
end

%-------------------------------------------------------------------------- 
%                        E N D   M A I N   L O O P 
%-------------------------------------------------------------------------- 


