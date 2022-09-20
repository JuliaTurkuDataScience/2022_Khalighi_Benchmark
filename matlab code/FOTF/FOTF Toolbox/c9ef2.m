function f=c9ef2(x), t=[0:0.01:20]';
% c9ef1 - MATLAB function to express ITAE criterion of the system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
s=tf('s'); G=1/(s+1)^5; Gc=x(1)+x(2)/s+x(3)*s;
e=step(feedback(1,Gc*G),t); f=sum(t.*abs(e))*(t(2)-t(1));
