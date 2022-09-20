function [F,r]=contfrac(f,s,n,a)
% contfrac - the interface to the MuPAD function contfrac
%
%   [cf,r]=contfrac(f,s,n,a)
%   
%   f - the symbolic expression of the original function
%   s - the independent variable
%   n - the approximation order of continued fractions
%   a - the reference point
%   cf - the symbolic expression of the continued fraction
%   r - the symbolic expression of the rational form 

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last modified 28 March, 2017
% Not recommended for the less support of MuPAD contfrac function
   arguments, f(1,1), s(1,1), n(1,1), a(1,1), end
   F=feval(symengine,'contfrac',f,[inputname(2) '=' num2str(a)],n);
   if nargout==2
      r=feval(symengine,'contfrac::rational',F);
end, end
