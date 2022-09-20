function y=fode_caputo9(a,na,b,nb,y0,u,t,p)
% fode_caputo9 -  O(h^p) Caputo FODE solver with nonzero initial conditions
%
%   y=fode_caputo9(a,na,b,nb,y0,u,t,p)
%   
%   a,na,b,nb - coefficients/order vectors of numerator and denominator
%   y0 - the initial vector of the output and its integer-order derivatives
%   u - the samples of the input signal
%   t - the time vector, corresponding to u
%   p - the precision O(h^p) setting
%   y - the solutions of the Caputo equation, with O(h^p)

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      a(1,:), na(1,:), b(1,:), nb(1,:), y0(:,1), u(:,1), t(:,1)
      p(1,1) {mustBePositiveInteger}=5
   end
   T=0; dT=0; 
   if p>length(y0)
      yy0=caputo_ics(a,na,b,nb,y0,u(1:p),t(1:p)); 
      y0=yy0(1:p).*gamma(1:p)';
   elseif p==length(y0)
      yy0=caputo_ics(a,na,b,nb,y0,u(1:p+1),t(1:p+1)); 
      y0=yy0(1:p+1).*gamma(1:p+1)';
   end
   for i=1:length(y0), T=T+y0(i)/gamma(i)*t.^(i-1); end
   for i=1:length(na), dT=dT+a(i)*caputo9(T,t,na(i),p); end
   u=u-dT; y=fode_sol9(a,na,b,nb,u,t,p)+T;
end
