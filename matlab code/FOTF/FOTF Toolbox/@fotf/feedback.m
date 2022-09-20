function G=feedback(F,H)
% feedback - find the overall model of two FOTF objects in feedback connection
%
%    G=feedback(G1,G2)
%
%   G1, G2 - the FOTF objects in the forward and backward paths
%   G - the overall model of the closed-loop system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   F=fotf(F); H=fotf(H); [n1,m1]=size(F); [n2,m2]=size(H);
   if n1*m1==1 && n2*m2==1
      if F.ioDelay==H.ioDelay
         G=fotf(F.den*H.den+F.num*H.num,F.num*H.den); 
         G=simplify(G); G.ioDelay=F.ioDelay;
      else, error('delay in incompatible'), end
   elseif n1==m1 && n1==n2 && n2==m2
      if maxdelay(F)==0 && maxdelay(H)==0
         G=inv(fotf(eye(size(F*H)))+F*H)*F; G=simplify(G);
      else, error('cannot handle blocks with delays'); end
   else, error('not equal sized square matrices'), end
end
