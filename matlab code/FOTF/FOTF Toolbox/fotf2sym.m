function G1=sym(G)
% FOTF2sym convert FOTF to symbolic expression such that
% more accurate computations are allowed.
% See also, sym2fotf to convert results back

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   [n,m]=size(G);
   for i=1:n, for j=1:m
      G1(i,j)=ppoly2sym(G(i,j).num)/ppoly2sym(G(i,j).den);
end, end, end
