function rlocus(G)
% rlocus - draw the root locus of a SISO FOSS object
%
%   rlocus(G)
% 
%   G - a SISO FOSS object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   rlocus(fotf(G))
end
