function H=carlson_fod(alpha,G,iter,epsx)
% carlson_fod - design function for the Carlson filter
%
%   H=carlson_fod(alpha,G,iter)
%   
%   alpha - the fractional order
%   G - the integer-order model
%   iter - the number of iterations
%   H - the Carlson filter such that H approx G^alpha

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   arguments
      alpha(1,1) double, G(1,1)
      iter(1,1) {mustBePositiveInteger}, epsx(1,1)=eps;
   end
   q=alpha; m=q/2; H=1; 
   for i=1:iter
      H=minreal(H*((q-m)*H^2+(q+m)*G)/((q+m)*H^2+(q-m)*G),epsx);
   end 
end
