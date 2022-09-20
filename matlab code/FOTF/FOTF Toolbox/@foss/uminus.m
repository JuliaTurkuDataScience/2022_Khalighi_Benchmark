function G=uminus(G1)
% uminus - unary minus of an FOSS object
%
%   G1=-G
% 
%   G - an FOSS object
%   G1- the unary minus of G, i.e., -G

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   G=G1; G.c=-G1.c; G.d=-G1.d;
end
