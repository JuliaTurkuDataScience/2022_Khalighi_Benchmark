function alpha=base_order(G)
% base_order - find the base order of an FOTF object
%
%    alpha=base_order(G)
%
%   G - an FOTF object
%   alpha - the base order of the system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); a=[];
   for i=1:n, for j=1:m, g=G(i,j); a=[a,g.num.na,g.den.na]; end, end
   alpha=double(gcd(sym(a)));
end
