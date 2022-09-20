function y=optfpid_fun(x)
assignin('base','Kp',x(1)); assignin('base','Ki',x(2));
assignin('base','Kd',x(3)); assignin('base','lam',x(4));
assignin('base','mu0',x(5));
try
   [~,~,y_out]=sim('c9mfpidd',[0,20.000000]);
catch, y_out=1e10; end
y=y_out(end,1);
