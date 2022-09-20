function G=mrdivide(G1,G2)
% mldivide - right division of two FOTF objects
%
%   G=G1/G2

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   G1=fotf(G1); G2=fotf(G2); 
   if maxdelay(G1)==0 && maxdelay(G2)==0, G=G1*inv(G2); 
   else, error('block with positive delay'); end
end
