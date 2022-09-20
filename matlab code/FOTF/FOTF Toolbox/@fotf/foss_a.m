function G1=foss_a(G) 
% foss_a - convert an FOTF object into an extended FOSS object
%
%    G1=foss_a(G)
%
%   G - the FOTF object
%   G1 - the equivalent extended FOSS object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); n0=[]; 
   for i=1:n, for j=1:m, g=G(i,j); n0=[n0, g.nn g.nd]; end, end
   n0=unique(n0); n1=n0(end:-1:1);
   for i=1:n, for j=1:m, g=G(i,j); 
      num=[]; den=[]; nn=g.nn; nd=g.nd; b=g.num; a=g.den;
      for k=1:length(nn), t=find(nn(k)==n1); num(t)=b(k); end
      for k=1:length(nd), t=find(nd(k)==n1); den(t)=a(k); end
      Gt(i,j)=tf(num,den); T(i,j)=g.ioDelay;
   end, end
   Gf=ss(Gt); E=Gf.e; [a,b,c,d]=dssdata(Gf);
   alpha=-diff(n1); G1=foss(a,b,c,d,alpha,T,E);
end
