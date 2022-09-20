function G=simplify(G,eps1)
% simplify - simplification of an FOTF object
%
%   G=simplify(G1,eps1)
% 
%   G1 - a FOTF object
%   eps1 - error tolerance
%   G - simplified FOTF object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); if nargin==1, eps1=eps; end
   for i=1:n, for j=1:m
      g=G(i,j); num=g.num.a; den=g.den.a; nn=g.num.na; nd=g.den.na; 
      i1=abs(num)>eps1; i2=abs(den)>eps1; num=num(i1); den=den(i2); 
      nn=nn(i1); nd=nd(i2); n0=min(nn); d0=min(nd); 
      na=min(n0,d0); if isempty(na), na=0; end 
      G(i,j)=fotf(den,nd-na,num,nn-na,g.ioDelay);     
end, end, end
