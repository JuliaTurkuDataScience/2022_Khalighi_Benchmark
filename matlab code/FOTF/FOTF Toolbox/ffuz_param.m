function [sys,x0,str,ts]=ffuz_param(t,x,u,flag,T,fuz,K0)
% ffuz_param - S-function of the fuzzy inference system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
switch flag
   case 0, [sys,x0,str,ts] = mdlInitializeSizes(T);
   case 2, sys = mdlUpdates(x,u);
   case 3, sys = mdlOutputs(x,u,fuz,K0);
   case {1, 4, 9}, sys = [];
   otherwise, error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes(T)
sizes=simsizes;
sizes.NumContStates=0; sizes.NumDiscStates=2;
sizes.NumOutputs=5; sizes.NumInputs=1;
sizes.DirFeedthrough=0; sizes.NumSampleTimes=1;
sys=simsizes(sizes); x0=zeros(2,1); str=[]; ts=[T 0];
%
function sys = mdlUpdates(x,u)
sys=[u(1); u(1)-x(1)];
%
function sys = mdlOutputs(x,u,fuz,K0)
Kfpid=K0+evalfis([x(1),x(2)],fuz)';
assignin('base','Kp',Kfpid(1));
assignin('base','Ki',Kfpid(2));
assignin('base','Kd',Kfpid(3));
assignin('base','lam',Kfpid(4));
assignin('base','mu0',Kfpid(5)); sys=Kfpid;
