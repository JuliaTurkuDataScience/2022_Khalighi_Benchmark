function dy=glfdiff(y,t,gam)
% glfdiff_mat - evaluation of O(h) GL derivatives with matrix algorithm 
%
%   dy=glfdiff_mat(y,t,gam)
%
%   y - the samples of the function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   dy - the fractional-order derivatives, or integrals if gam<0
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, y(:,1), t(:,1) double, gam(1,1) double, end
   [y,h,n]=fdiffcom(y,t); w=[1,zeros(1,n-1)]; 
   for j=2:n, w(j)=w(j-1)*(1-(gam+1)/(j-1)); end
   dy=rot90(hankel(w(end:-1:1)))*y/h^gam;
end
