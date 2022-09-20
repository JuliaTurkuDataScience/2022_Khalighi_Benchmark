function y=c8mexp2m(t,x)
% c8mexp2m - MATLAB function to express the nonlinear fractional-order
%            differential equation

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   y3=-t^0.1*ml_func([1,1.545],-t)/ml_func([1,1.445],-t)...
         *exp(t)*x(1)*x(2)+exp(-2*t)-x(3)^2;
   y=[x(2); x(3); y3];
end
