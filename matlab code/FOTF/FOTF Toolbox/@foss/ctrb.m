function Tc=ctrb(G)
% ctrb - create a controllability test matrix for an FOSS
%
%    Tc=ctrb(G)
%
%   G - the FOSS object
%   Tc - the controllability test matrix

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   Tc=ctrb(G.a,G.b);
end
