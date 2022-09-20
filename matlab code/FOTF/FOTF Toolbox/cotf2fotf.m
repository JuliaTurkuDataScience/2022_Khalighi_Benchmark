function G1=cotf2fotf(G,alpha)
% cotf2fotf - commensurate order TF to FOTF object conversion
%
%   G1=cotf2fotf(G,alpha)
%   
%   G - the integer-order TF to describe the commensurate-order system
%   alpha - the base order
%   G1 - the converted FOTF object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last modified 18 May, 2022
   [n,m]=size(G); G1=fotf(G);
   for i=1:n, for j=1:m, g=fotf(G(i,j)); 
      g.num.na=g.num.na*alpha; g.den.na=g.den.na*alpha; G1(i,j)=g;
end, end, end
