%函数功能为计数
function [J,lam] = cout(H,x,y,C,ind,c,A,b,lambda)

  
	[n,m] = size(H);  
	X = zeros(n,1);  
	posok = find(ind > 0);  
	posA = find(ind==0);			
	posB = find(ind==-1);			  
			                                                
	X(posok) = x;  
	X(posB) = C(posB);    

	J = 0.5 *X'*H*X  - c'*X;   
				               

lam = 0; 
    
    
