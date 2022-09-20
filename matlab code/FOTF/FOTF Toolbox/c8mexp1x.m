function y=c8mexp1x(t,x,k)
% c8mexp1x - MATLAB function to express the nonlinear fractional-order
%            differential equation

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   if k<3, y=x(k+1);
   else
      y=-t^0.1*ml_func([1,1.545],-t)/ml_func([1,1.445],-t)...
         *exp(t)*x(1)*x(2)+exp(-2*t)-x(3)^2;
   end
end   
