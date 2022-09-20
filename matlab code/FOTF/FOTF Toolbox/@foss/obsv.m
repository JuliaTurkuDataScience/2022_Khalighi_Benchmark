function To=obsv(G) 
% obsv - create an observability test matrix for an FOSS
%
%    To=obsv(G)
%
%   G - the FOSS object
%   To - the observability test matrix

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   To=obsv(G.a,G.c);
end
