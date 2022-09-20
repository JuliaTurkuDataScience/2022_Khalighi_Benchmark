function g=genfunc(p)
% genfunc - computing the generating function vector 
%
%   g=genfunc(p)
%
%   p - the order of precision p
%   g - the coefficients of the generating function as a symbolic variable
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, p(1,1) {mustBePositiveInteger}, end
   a=1:p+1; A=rot90(vander(a)); g=(1-a)/sym(A');
end
