function G1=fotf2foss(G)
% fotf2foss - convert an FOTF object to FOSS one
%
%   G1=fotf2foss(G)
% 
%   G - an FOTF object
%   G1 - an equivalent FOSS object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G);
   [G2,alpha]=fotf2cotf(G); G2=minreal(G2); G2=ss(G2);
   for i=1:n, for j=1:m, g=G(i,j); T(i,j)=g.ioDelay; end, end
   G1=foss(G2.a,G2.b,G2.c,G2.d,alpha,T,G2.E);
end
