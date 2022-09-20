function G=uminus(G) 
% uminus - unary minus of an FOTFS object
%
%   G1=-G
% 
%   G - an FOT object
%   G1- the unary minus of G, i.e., -G

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G);
   for i=1:n, for j=1:m, G(i,j).num=-G(i,j).num; end, end
end
