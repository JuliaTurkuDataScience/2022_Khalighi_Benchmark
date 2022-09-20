function y = c8mmlfs1(u)
% c8mmlfs1 - MATLAB function to express the Simulink block

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   y = u^(1.5-sqrt(2))*exp(u)*ml_func([1,3-sqrt(2)],-u)./ml_func([1,1.5],-u);
end
