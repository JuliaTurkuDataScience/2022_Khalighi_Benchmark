function G1=coss_aug(G,k)
% coss_aug - state augmentation of an FOSS object
%
%    G1=coss_aug(G,k)
%
%   G - the FOSS object
%   k - integer so that original n states can be augmented into n*k states
%   G1 - the augmented FOSS model

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if G.alpha==0 || k==1, G1=G;
   else, alpha=G.alpha/k; G=fotf(G); [n,m]=size(G);
      for i=1:n, for j=1:m, g=G(i,j); 
         a=g.den.a; na=g.den.na; b=g.num.a; nb=g.num.na;
         ii=1:k:k*length(a); a1(ii)=a;
         ii=1:k:k*length(b); b1(ii)=b; G2(i,j)=tf(b1,a1);
      end, end
      G1=foss(ss(G2)); G1.alpha=alpha;
end, end
