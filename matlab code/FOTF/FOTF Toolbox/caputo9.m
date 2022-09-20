function dy=caputo9(y,t,gam,p)
% caputo9 - O(h^p) Caputo derivative computation function
%
%   dy=caputo9(y,t,gam,p)
%   
%   y - the samples or function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   p - the order for precision
%   dy - the Caputo derivative

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   arguments, y(:,1), t(:,1) double, gam(1,1) double
      p(1,1) {mustBePositiveInteger}=5
   end
   if strcmp(class(y),'function_handle'), y=y(t); end
   if gam<0, dy=glfdiff9(y,t,gam,p); return; end
   h=t(2)-t(1); q=ceil(gam); 
   r=max(p,q); R=fliplr(vander((sym(0):(r-1))'*h));
   c=double(R\y(1:r)); u=0; du=0;
   for i=1:r, u=u+c(i)*t.^(i-1); end
   if q<r
      for i=(q+1):p
         du=du+c(i)*t.^(i-1-gam)*gamma(i)/gamma(i-gam);
   end, end
   v=y-u; dv=glfdiff9(v,t,gam,p); dy=dv+du;
end
