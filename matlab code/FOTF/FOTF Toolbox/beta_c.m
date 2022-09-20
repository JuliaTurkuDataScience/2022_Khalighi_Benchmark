function y=beta_c(z,m)
% gamma_c - beta function with complex arguments
%
%   y=beta_c(z,m)
%
%   z,m - the independent variable containing complex quantities 
%   y - the values of the Gamma function
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Created 28 March, 2017 
% Last Modified 18 May, 2022
   if isreal(z), y=beta(z,m);
   else, f=@(t)t.^(z-1).*(1-t).^(m-1);
      y=integral(f,0,1,'ArrayValued',true);
   end
end
