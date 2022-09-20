function y=ml_step3(a,b,t,eps0)
% ml_step3 - step response of three-term FODE
%
%   y=ml_step3(a1,a2,a3,b1,b2,t,eps0)
%
%   a1, a2, a3, b1, b2 - the parameters of the three-term FODE
%   t - the time vector
%   eps0 - the error tolerance
%   y - the numerical solutions of the three-term FODE
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, a(1,3), b(1,2), t(:,1), eps0(1,1)=eps; end
   y=0; k=0; ya=1; 
   a1=a(1); a2=a(2)/a1; a3=a(3)/a1; b1=b(1); b2=b(2);
   while max(abs(ya))>=eps0
      ya=(-1)^k/gamma(k+1)*a3^k*t.^((k+1)*b1).*...
          ml_func([b1-b2,b1+b2*k+1],-a2*t.^(b1-b2),k,eps0);
      y=y+ya; k=k+1;
   end, y=y/a1;
end
