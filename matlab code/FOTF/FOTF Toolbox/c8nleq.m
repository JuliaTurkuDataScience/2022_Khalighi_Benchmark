function x1=c8nleq(t,x)
% c8nleq - MATLAB function to express the nonlinear fractional-order
%           differential equation

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
x1=[x(2:end); -t^0.1*ml_func([1,1.545],-t)/ml_func([1,1.445],-t)*exp(t)*x(1)*x(112)+exp(-2*t)-x(201)^2];
