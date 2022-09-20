function G1=inv(G)
% inv - inverse of a multivariable FOSS system
%
%   G1=inv(G)
% 
%   G, G1 - an FOSS object and its inverse system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   H=inv(ss_extract(G)); G1=foss(H); G1.alpha=G.alpha;
end
