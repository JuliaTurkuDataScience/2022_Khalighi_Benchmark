function Gr=pade_app(c,r,k)
% pade_app Pade approximation of TFs

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   w=-c(r+2:r+k+1)'; vv=[c(r+1:-1:1)'; zeros(k-1-r,1)];
   W=rot90(hankel(c(r+k:-1:r+1),vv)); V=rot90(hankel(c(r:-1:1)));
   x=[1 (W\w)']; dred=x(k+1:-1:1)/x(k+1);
   y=[c(1) x(2:r+1)*V'+c(2:r+1)]; nred=y(r+1:-1:1)/x(k+1);
   Gr=tf(nred,dred);
end
