function [fy,C]=fpidfuns(x)
% fpidfuns - general objective function for optimum fractional-order PID

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   global G t key1 key2 C
   s=fotf('s'); t=t(:); 
   switch key1
      case {'fpid',1}, C=x(1)+x(2)*s^(-x(4))+x(3)*s^(x(5));
      case {'fpi',2}, C=x(1)+x(2)*s^(-x(3));
      case {'fpd',3}, C=x(1)+x(2)*s^x(3);
      case {'fpidx',4}, C=x(1)+x(2)/s+x(3)*s^x(4);
      case {'pid','PID',5}, C=x(1)+x(2)/s+x(3)*s;
   end
   dt=t(2)-t(1); e=step(feedback(1,G*C),t); e=e(:).';
   switch key2
      case {'itae','ITAE',1}, fy=dt*abs(e)*t;
      case {'ise','ISE',2}, fy=dt*sum(e.^2);
      case {'iae','IAE',3}, fy=dt*sum(abs(e));
      case {'itse','ITSE',4}, fy=dt*e.^2*t;
      otherwise
         error('Available criteria are itae, ise, iae, itse.')
   end
   disp([x(:).' fy])
end
