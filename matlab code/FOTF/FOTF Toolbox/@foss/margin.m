function [Gm,Pm,Wcg,Wcp]=margin(G)
% margin - gain and phase margins of an FOSS object
%
%   [Gm,Pm,Wcg,Wcp]=margin(G)
% 
%   G - an FOSS object
%   Gm, Wcg - gain margin in dBs and the corresponding frequency
%   Pm, Wcp - phase margin in degrees and the crossover frequency

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [Gm,Pm,Wcg,Wcp]=margin(fotf(G));
end
