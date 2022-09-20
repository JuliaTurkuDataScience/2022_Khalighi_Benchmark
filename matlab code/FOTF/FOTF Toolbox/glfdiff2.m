function dy=glfdiff2(y,t,gam,p)
% glfdiff2 - evaluation of O(h^p) GL derivatives, not recommended 
%
%   dy=glfdiff2(y,t,gam,p)
%
%   y - the samples of the function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   p - the order for the precision setting
%   dy - the fractional-order derivatives, or integrals if gam<0
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, y(:,1), t(:,1), gam(1,1)
      p(1,1){mustBePositive, mustBeInteger}=5
   end
   g=double(genfunc(p)); [y,h,n]=fdiffcom(y,t); 
   w=get_vecw(gam,n,g); dy=zeros(n,1);
   for i=1:n, dy(i)=w(1:i)*y(i:-1:1)/h^gam; end
end
