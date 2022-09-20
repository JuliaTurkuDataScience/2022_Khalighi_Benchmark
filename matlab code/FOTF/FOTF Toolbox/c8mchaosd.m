function Y=c8mchaosd(u)
% c8mchaosd - MATLAB function to express the chaotic Chua system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Created 28 March, 2017
% Last Modified 18 May, 2022
   a=10.725; b=10.593; c=0.268; m0=-1.1726; m1=-0.7872;
   f=m1*u(1)+1/2*(m0-m1)*(abs(u(1)+1)-abs(u(1)-1));
   Y=[a*(u(2)-u(1)-f); u(1)-u(2)+u(3); -b*u(2)-c*u(3)];
end