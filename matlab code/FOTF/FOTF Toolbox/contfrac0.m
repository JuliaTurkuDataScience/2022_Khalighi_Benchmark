function [cf,r]=contfrac0(f,s,n,a)
% contfrac0 - the interface to the MuPAD function contfrac
%
%   [cf,r]=contfrac0(f,s,n,a)
%   
%   f - the symbolic expression of the original function
%   s - the independent variable
%   n - the approximation order of continued fractions
%   a - the reference point
%   cf - the symbolic expression of the continued fraction
%   r - the symbolic expression of the rational form 

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
cf=feval(symengine,'contfrac',f,[inputname(2) '=' num2str(a)],n);
if nargout==2
   r=feval(symengine,'contfrac::rational',cf);
end
