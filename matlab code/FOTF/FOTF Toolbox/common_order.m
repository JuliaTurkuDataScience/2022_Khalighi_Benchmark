function a=common_order(varargin)
% common_order - extract the common order from a set of orders
%
%   a=common_order(a1,a2,a3,...)
%   
%   a1, a2, a3,... - the given set of orders
%   a - the common order

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
a0=cell2mat(varargin); [c,d]=rat(a0,1e-20);
a=double(gcd(sym(c))/lcm(sym(d)));
