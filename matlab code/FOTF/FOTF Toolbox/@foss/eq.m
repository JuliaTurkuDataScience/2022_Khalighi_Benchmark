function key=eq(G1,G2)
% eq - test whether two FOSS objects are equal or not
%
%    key=G1==G2
%
%   G1, G2 - the two FOSS objects
%   key = 1 for equal, otherwise key = 0

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   key=fotf(G1)==fotf(G2);
end