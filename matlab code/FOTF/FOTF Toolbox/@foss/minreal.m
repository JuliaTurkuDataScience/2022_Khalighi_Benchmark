function G=minreal(G1)
% minreal - minimum realisation of an FOSS object
%
%   G=minreal(G1)
% 
%   G1 - an FOSS object
%   G - minimum realisation of G1 as an FOSS object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   alpha=G1.alpha; G2=ss_extract(G1); G2=minreal(G2); 
   G=foss(G2); G.alpha=alpha;
end
