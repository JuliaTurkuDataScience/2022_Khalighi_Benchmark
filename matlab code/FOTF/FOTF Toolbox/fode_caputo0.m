function [y,z]=fode_caputo0(a,na,b,nb,y0,u,t)
% fode_caputo0 -  simple Caputo FODE solver with nonzero initial conditions
%
%   [y,z]=fode_caputo0(a,na,b,nb,y0,u,t)
%   
%   a,na,b,nb - coefficients/order vectors of numerator and denominator
%   y0 - the initial vector of the output and its integer-order derivatives
%   u - the samples of the input signal
%   t - the time vector, corresponding to u
%   y - the solutions of the Caputo equation, with O(h)
%   z - the solution portion for zero initial condition ones

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      a(1,:), na(1,:), b(1,:), nb(1,:), y0(:,1), u(:,1), t(:,1) 
   end
   h=t(2)-t(1); T=0; P=0; U=0;
   for i=1:length(y0), T=T+y0(i)*t.^(i-1)/gamma(i); end
   for i=1:length(na), P=P+a(i)*caputo9(T,t,na(i),5); end
   for i=1:length(nb), U=U+b(i)*caputo9(u,t,nb(i),5); end
   z=fode_sol(a,na,1,0,U-P.',t); y=z+T;
end
