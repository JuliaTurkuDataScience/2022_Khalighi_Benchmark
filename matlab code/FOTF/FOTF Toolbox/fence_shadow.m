function fence_shadow(t,f,gam,key)
% fence_shadow - geometric interpretation of the fractional-order integrals
%
%   fence_shadow(t,f,gam,key)
%   
%   t - the tine vector
%   f - the function handle of the original function
%   gam - the integral order
%   key - the three types of graphs, as in Igor Podlubny's paper

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, t(1,:), f, gam(1,1) double
      key(1,1) {mustBeMember(key,[1,2,3])};
   end
   x=t; z=f(x); tn=x(end);
   switch key
      case 1, y=(tn^gam-(tn-x).^gam)/gamma(1+gam);
         axis([minmax(x),minmax(y),minmax(z)]), hold on
         for i=1:length(x)-1, ii=[i,i,i+1,i+1]; x0=x(ii);
            z0=[0 z(i:i+1) 0]; y0=[0 0 0 0]; patch(x0,y0,z0,'c')
            y0=y(ii); patch(x0,y0,z0,'g')
            x0=[0 0 0 0]; patch(x0,y0,z0,'r')
         end, view(-37.5000,30)
      case {2,3}, axis([minmax(x),minmax(z)]), hold on
         for i=1:length(x)-1, x1=0:0.01:x(i+1);
            tn=x1(end); y=(tn^gam-(tn-x1).^gam)/gamma(1+gam);
            if key==2, plot(x1,y);
            else, z=f(x1); plot(y,z,[y(end),y(end)],[z(end),0]);
   end, end, end, hold off
end
