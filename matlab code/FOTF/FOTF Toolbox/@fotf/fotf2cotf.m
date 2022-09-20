function [G1,alpha]=fotf2cotf(G)
% fotf2cotf - convert an FOTF object into a commensurate-order one
%
%   [G1,alpha]=fotf2cotf(G)
%
%   G - an FOTF object
%   G1 - an equivalent commensurate-order FOTF 
%   alpha - the base order

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); alpha=base_order(G);
   if alpha==0
      for i=1:n, for j=1:m
         g=G(i,j); a=g.den.a; b=g.num.a; D(i,j)=b(1)/a(1); T(i,j)=g.ioDelay;
      end, end, G1=tf(D); 
   else
      for i=1:n, for j=1:m, g=G(i,j); a=[]; b=[];
         n0=round(g.den.na/alpha); a(n0+1)=g.den.a; a=a(end:-1:1);
         m0=round(g.num.na/alpha); b(m0+1)=g.num.a; b=b(end:-1:1);
         g1=tf(b,a); G1(i,j)=g1; T(i,j)=g.ioDelay;
   end, end, end
   G1.ioDelay=T;
end
