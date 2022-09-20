function [nP,dP]=padefcn(c,r,m)
% padefcn Pade approximation with time moments

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   w=-c(r+2:m+r+1)'; vv=[c(r+1:-1:1)'; zeros(m-1-r,1)];
   W=rot90(hankel(c(m+r:-1:r+1),vv)); V=rot90(hankel(c(r:-1:1)));
   x=[1 (W\w)']; y=[1 x(2:r+1)*V'+c(2:r+1)];
   dP=x(m+1:-1:1)/x(m+1); nP=y(r+1:-1:1)/x(m+1);
end
