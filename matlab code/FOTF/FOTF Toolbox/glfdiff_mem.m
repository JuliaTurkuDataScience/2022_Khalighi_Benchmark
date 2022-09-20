function dy=glfdiff_mem(y,t,gam,L0)
% glfdiff_mem - evaluation of O(h) GL derivatives with short memory principle 
%
%   dy=glfdiff_mem(y,t,gam,L0)
%
%   y - the samples of the function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   L0 - the memory length
%   dy - the fractional-order derivatives, or integrals if gam<0
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, y(:,1), t(:,1), gam(1,1), L0=length(t); end
   [y,h,n]=fdiffcom(y,t); w=[1,zeros(1,n-1)]; dy(1)=0; 
   for j=2:L0+1, w(j)=w(j-1)*(1-(gam+1)/(j-1)); end
   for i=1:n
      L=min([i,L0]); dy(i,1)=w(1:L)*y(i:-1:i-L+1)/h^gam;
   end
end
