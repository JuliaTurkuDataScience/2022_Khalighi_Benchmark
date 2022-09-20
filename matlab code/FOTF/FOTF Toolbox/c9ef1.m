function f=c9ef1(x), t=[0:0.01:20]';
% c9ef1 - MATLAB function to express ISE criterion of the system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
s=tf('s'); G=1/(s+1)^5; Gc=x(1)+x(2)/s+x(3)*s;
e=step(feedback(1,Gc*G),t); f=sum(e.^2)*(t(2)-t(1));
