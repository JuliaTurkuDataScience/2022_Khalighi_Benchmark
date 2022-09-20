function [c,ceq]=c2exnls(x)
% c2exnls - MATLAB function to describe an objective function in
%           an example of the book, in Chapter 2

% Copyright (c) Dingyu Xue, Northeastern University, China
% Created 28 March, 2017
% Last Modified 18 May, 2022
   c=[];
   ceq=[x(3)+9.625*x(1)*x(4)+16*x(2)*x(4)+16*x(4)^2+...
             12-4*x(1)-x(2)-78*x(4);
        16*x(1)*x(4)+44-19*x(1)-8*x(2)-x(3)-24*x(4)];
end
