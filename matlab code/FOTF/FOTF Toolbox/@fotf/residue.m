function [alpha,r,p,K]=residue(G)
% residue - partial fraction expansion of a SISO FOTF object
%
%   [alpha,r,p,K]=residue(G)
% 
%   G - a SISO commensurate-order FOTF object
%   alpha - base order
%   r, p, K - the definitions are the same as the conventional residue function

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [H,alpha]=fotf2cotf(G); [r,p,K]=residue(H.num{1},H.den{1});
end