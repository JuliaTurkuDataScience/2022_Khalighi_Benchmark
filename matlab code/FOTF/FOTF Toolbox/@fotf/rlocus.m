function rlocus(G)
% rlocus - draw the root locus of a SISO FOTF object
%
%   rlocus(G)
% 
%   G - a SISO FOTF object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if numel(G)==1
      [G1,alpha]=fotf2cotf(G); rlocus(G1), xm=xlim;
      if alpha<1, xm(1)=0; else, xm(2)=0; end
      line(xm,tan(alpha*pi/2)*xm), line(xm,-tan(alpha*pi/2)*xm)
      line(xm,tan(alpha*pi)*xm), line(xm,-tan(alpha*pi)*xm)
   else
      error('Root locus only applies to SISO systems');
   end
end
