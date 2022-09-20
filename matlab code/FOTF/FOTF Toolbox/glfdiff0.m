function [df,C]=glfdiff0(f,t,gam)
% glfdiff0 - evaluation of GL derivatives, not recommended 
%
%   dy=glfdiff0(y,t,gam)
%
%   y - the samples of the function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   dy - the fractional-order derivatives, or integrals if gam<0
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, f(1,:), t(1,:) double, gam(1,1) double, end
   [f,h,n]=fdiffcom(f,t);  J=0:(n-1); a0=f(1);
   if a0~=0 && gam>0, dy(1)=sign(a0)*Inf; end
   C=gamma(gam+1)*(-1).^J./gamma(J+1)./gamma(gam-J+1)/h^gam;
   for i=2:n, dy(i)=C(1:i)*f(i:-1:1); end
end