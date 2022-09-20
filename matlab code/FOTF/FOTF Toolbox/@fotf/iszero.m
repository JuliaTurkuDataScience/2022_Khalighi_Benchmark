function key=iszero(g)
% iszero - check whether a SISO FOTF object is zero or not
%
%   key=iszero(G)
% 
%   G - a SISO FOTF object
%   key - identifier, if G is zero, then key = 1.

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   key=0; [~,~,b,nb]=fotfdata(g);
   if isempty(b) || (length(nb)==1 && abs(b(1))<eps), key=1; end
end
