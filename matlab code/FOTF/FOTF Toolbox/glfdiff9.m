function dy=glfdiff9(y,t,gam,p)
% glfdiff9 - evaluation of O(h^p) GL derivatives, recommended 
%
%   dy=glfdiff9(y,t,gam,p)
%
%   y - the samples of the function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   p - the order for the precision setting
%   dy - the fractional-order derivatives, or integrals if gam<0
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, y(:,1), t(:,1) double, gam(1,1) double
      p(1,1){mustBePositiveInteger}=5
   end
   [y,h,n]=fdiffcom(y,t); u=0; du=0; r=(0:p)*h;
   R=sym(fliplr(vander(r))); c=double(R)\y(1:p+1);
   for i=1:p+1, u=u+c(i)*t.^(i-1);
      du=du+c(i)*t.^(i-1-gam)*gamma(i)/gamma(i-gam);
   end
   v=y-u; g=double(genfunc(p)); w=get_vecw(gam,n,g);
   for i=1:n, dv(i,1)=w(1:i)*v(i:-1:1)/h^gam; end
   dy=dv+du; if abs(y(1))<1e-10, dy(1)=0; end
end
