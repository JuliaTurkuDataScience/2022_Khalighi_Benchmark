function G=mldivide(G1,G2)
% mldivide - left division of two FOTF objects
%
%   G=G1\G2

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
G1=fotf(G1); G2=fotf(G2);
if maxdelay(G)==0 && maxdelay(G2)==0, G=inv(G1)*G2;
else, warning('block with positive delay'); end
