function [sys,x0,str,ts]=sfun_mls(t,x,u,flag,a)
% sfun_mls - S-function version of Mittag-Leffler function for Simulink
%
%   The additional parameter a for Mittag-Leffler coefficients

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
switch flag
   case 0, sizes = simsizes;
      sizes.NumContStates = 0; sizes.NumDiscStates = 0;
      sizes.NumOutputs = 1; sizes.NumInputs = 1;
      sizes.DirFeedthrough = 1; sizes.NumSampleTimes = 1;
      sys = simsizes(sizes); x0 = []; str = []; ts = [-1 0];
   case 3, sys = ml_func(a,u);
   case {1,2,4,9}, sys = [];
   otherwise, error(['Unhandled flag = ',num2str(flag)]);
end
