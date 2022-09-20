function [dy,t]=rlfdiff(y,t,r)
% rlfdiff - computation of RL derivatives, not recommended
%
%    [dy,t]=rlfdiff(y,t,r)
%
%   y, t - the samples of the function at time vector t
%   r - the fractional order, can be nagative for integrals
%   dy - the Riemann-Liouville derivative of y

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, y(:,1), t(:,1) double, r(1,1) double, end
   [y,h,n]=fdiffcom(y,t); dy1=zeros(1,n);
   if r>-1, m=ceil(r)+1; p=m-r; y3=t.^(p-1);
   elseif r==-1
      yy=0.5*(y(1:n-1)+y(2:n)).*diff(t);  
      for i=2:n, dy(i)=dy(i-1)+yy(i-1); end, return
   else, m=-r; y3=t.^(m-1); end
   for i=1:n, dy1(i)=y(i:-1:1).'*(y3(1:i)); end
   if r>-1, dy=diff(dy1,m)/(h^(m-1))/gamma(p); t=t(1:n-m);
   else, dy=dy1*h/gamma(m); end, dy=dy(:);
end

