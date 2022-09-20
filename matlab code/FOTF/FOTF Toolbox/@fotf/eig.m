function p=eig(G) 
% eig - finding all the pseudo poles of an FOTF object
%
%    p=eig(G)
%
%   G - the FOTF object
%   p - all the pseudo-poles of G

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   p=eig(foss(G));
end
