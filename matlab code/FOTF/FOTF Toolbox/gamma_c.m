function y=gamma_c(z)
% gamma_c - Gamma function with complex arguments
%
%   y=gamma_c(z)
%
%   z - the independent variable containing complex quantities 
%   y - the values of the Gamma function
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if isreal(z), y=gamma(z);
   else, f=@(t)exp(-t).*t.^(z-1);
      y=integral(f,0,inf,'ArrayValued',true);
   end
end
