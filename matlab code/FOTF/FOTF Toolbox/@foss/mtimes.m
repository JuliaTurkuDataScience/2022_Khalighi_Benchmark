function G=mtimes(G1,G2)
% mpower - product of two FOSS objects, series connection
%
%   G=G1*G2
% 
%   G1, G2 - FOSS objects
%   G - returns the product of the two FOSS objects

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   G1=foss(G1); G2=foss(G2); 
   if length(G1.alpha)>1 || length(G2.alpha)>1, a=0.0001;
   else, a=common_order(G1.alpha,G2.alpha); end
   if a==0, G=foss([],[],[],G1.d*G2.d,0);
   elseif a<0.001, G1=fotf(G1); G2=fotf(G2); G=foss(G1*G2);
   else 
      G1=coss_aug(G1,round(G1.alpha/a));
      G2=coss_aug(G2,round(G2.alpha/a));
      G=foss(ss_extract(G1)*ss_extract(G2)); G.alpha=a;
   end
end
