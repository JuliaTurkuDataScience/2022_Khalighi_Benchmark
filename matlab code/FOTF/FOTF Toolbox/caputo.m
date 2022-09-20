function dy=caputo(y,t,gam,y0,L)
% caputo - O(h) Caputo derivative computation function
%
%   dy=caputo(y,t,alfa,y0,L)
%   
%   y - the samples or function handle of the original function
%   t - the time vector
%   alpha - the fractional order
%   y0 - the initial vector of signal and its integer-order derivatives
%   L0 - the interpolation length
%   dy - the Caputo derivative

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   arguments, y(:,1), t(:,1), gam(1,1), y0, L(1,1)=10, end
   dy=glfdiff(y,t,gam);
   if gam>0, q=ceil(gam); if gam<=1, y0=y(1); end
      for k=0:q-1, dy=dy-y0(k+1)*t.^(k-gam)./gamma(k+1-gam); end
      yy1=interp1(t(L+1:end),dy(L+1:end),t(1:L),'spline');
      dy(1:L)=yy1;
   end
end
