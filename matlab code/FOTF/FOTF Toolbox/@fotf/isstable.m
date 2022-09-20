function [K,alpha0,apol,p]=isstable(G,a0)
% isstable - check whether an FOTF object is stable or not
%
%   [K,alpha,apol]=isstable(G)
% 
%   G - an FOTF object
%   K- identifier to indicate the stability of G, returns 0, and 1
%   alpha - the common order
%   apol - all the pseudo poles of the system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n0,m0]=size(G); K=1; if nargin==1, a0=0.001; end
   for i=1:n0, for j=1:m0
      g=G(i,j); a=g.den.na; a1=fix(a/a0);
      if length(a1)==1 && a1==0
      else
         [g1,alpha]=fotf2cotf(g); c=g1.den{1};
         alpha0(i,j)=alpha; p0=roots(c); kk=[];
         for k=1:length(p0)
            a=g.den.a; na=g.den.na; pa=p0(k)^(1/alpha);
            if norm(a*[pa.^na'])<1e-6, kk=[kk,k]; end
         end
         p=p0(kk); subplot(n0,m0,(i-1)*m0+j),
         plot(real(p),imag(p),'x',0,0), xm=xlim;
         if alpha<1, xm(1)=0; else, xm(2)=0; end
         apol=min(abs(angle(p))); K=K*(apol>alpha*pi/2);
         a1=tan(alpha*pi/2)*xm; a2=tan(alpha*pi)*xm; 
         line(xm,a1), line(xm,-a1), line(xm,a2), line(xm,-a2)
         xlabel('Real Axis'), ylabel('Imaginary Axis')
   end, end, end
   title('Pole Map')
end
