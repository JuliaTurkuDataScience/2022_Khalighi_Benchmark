function y=c8mmlfs(t)
% c8mmlfs - MATLAB function to express the Simulink block

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   y=t^0.1*exp(t)*ml_func([1,1.545],-t)/ml_func([1,1.445],-t);
end
