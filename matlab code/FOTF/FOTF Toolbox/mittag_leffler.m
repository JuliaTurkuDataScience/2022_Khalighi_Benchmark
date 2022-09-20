function f=mittag_leffler(v,z)
% mittag_leffler - symbolic computation of Mittag-Leffler functions
%
%   f=mittag_leffler(alpha,z)
%   f=mittag_leffler([alpha,beta],z)
%   f=mittag_leffler([alpha,beta,gam],z)
%   f=mittag_leffler([alpha,beta,gam,q],z)
%
%   alpha, beta - the parameters for Mittag-Leffler functions
%   z - the independent variable
%   f - the Mittag-Leffler function.  MATLAB R2008a or earler are recommended
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, v(1,:), z(1,1); end
   v=sym([v,1,1,1]); a=v(1); b=v(2); c=v(3); q=v(4); syms k; 
   f=symsum(pochhammer(c,k*q)*z^k/gamma(a*k+b)/gamma(k+1),k,0,inf);
end