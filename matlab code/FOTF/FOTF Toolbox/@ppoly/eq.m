function key=eq(p1,p2)
% eq - test whether two PPOLY objects are equal or not
%
%    key=p1==p2
%
%   p1, p2 - the two PPOLY objects
%   key = 1 for equal, otherwise key = 0

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   g=collect(p1-p2); key=isempty(g.a);
end
