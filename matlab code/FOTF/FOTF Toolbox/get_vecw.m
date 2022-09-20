function w=get_vecw(gam,n,g)
% get_vecw - computation of O(h^p) weighting coefficients  
%
%   w=get_vecw(gam,n,g)
%
%   gam - the fractional order
%   n - 
%   g - the generating function vector
%   w - the weighting coefficients
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   p=length(g)-1; b=1+gam; g0=g(1);
   w=zeros(1,n); w(1)=g(1)^gam;
   for m=2:p, M=m-1; dA=b/M;
      w(m)=-g(2:m).*((1-dA):-dA:(1-b))*w(M:-1:1).'/g0;
   end
   for k=p+1:n, M=k-1; dA=b/M;
      w(k)=-g(2:(p+1)).*((1-dA):-dA:(1-p*dA))*w(M:-1:(k-p)).'/g0;
   end 
end
