function G1=ss_extract(G)
% ss_extract - extract the SS object from an FOSS object
%
%   G1=ss_extract(G)
% 
%   G - an FOSS object
%   G1 - the extracted integer-order state space model

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
   G1=ss(G.a,G.b,G.c,G.d); G1.E=G.E;
end
