function y=c8mfss2a(u)
% c8mfss2a - MATLAB function to express the fractional state space

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   y=[2/sqrt(pi)*(((u(2)-0.3)*(u(3)-0.5*u(1)))^(1/5)+sqrt(u(4)));
      gamma(1.4)/gamma(1.3)*((u(1)-1)/2)^0.3;
      gamma(3.1)/gamma(1.6)*sqrt((u(2)-0.3)^3)];
   y=real(y);   %for unknown reason, tiny imaginary part involved
end
