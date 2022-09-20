function [n,d]=paderm(tau,r,k)
% paderm Pade approximation of TFs with different orders

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   c(1)=1; for i=2:r+k+1, c(i)=-c(i-1)*tau/(i-1); end
   Gr=pade_app(c,r,k); n=Gr.num{1}(k-r+1:end); d=Gr.den{1};
end
