function fy=fpidfun(x,G,t,key)
% fpidfun - objective function for optimum fractional-order PID

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 19 May, 2022 
   arguments, x(1,:), G, t(:,1), key=1; end
   C=fopid(x); dt=t(2)-t(1); e=step(feedback(1,G*C),t); 
   if key==1, fy=dt*sum(t.*abs(e)); else, fy=dt*sum(e.^2); end
   disp([x(:).', fy])
end
