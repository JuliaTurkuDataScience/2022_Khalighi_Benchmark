function Ga=high_order(G0,filter,wb,wh,N,key)
% high_order - approximate an FOTF object with high-order TFs
%
%   Ga=high_order(G0,filter,wb,wh,N)
% 
%   G0 - an FOTF object
%   filter - can be 'ousta_fod', 'new_fod' and 'matsuda_fod'
%   wb, wh, N - the interested frequency interval and order of the filter
%   Ga - an equivalent TF object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      G0, filter='ousta_fod', wb(1,1){mustBeNumeric}=1e-3
      wh(1,1) {mustBeNumeric, mustBeGreaterThan(wh,wb)}=1e3
      N(1,1) {mustBeInteger, mustBePositive}=5, key=0
   end
   [n,m]=size(G0); F=filter;
   for i=1:n, for j=1:m
      if G0(i,j)==fotf(0), Ga(i,j)=tf(0);
      else, G=simplify(G0(i,j)); [a,na,b,nb]=fotfdata(G);
         G1=pseudo_poly(b,nb,F,wb,wh,N,key)/pseudo_poly(a,na,F,wb,wh,N,key);
         Ga(i,j)=minreal(G1);
end, end, end, end
% 伪多项式的近似
function p=pseudo_poly(a,na,filter,wb,wh,N,key)
   p=0; s=tf('s');
   for i=1:length(a), na0=na(i); n1=floor(na0); gam=na0-n1;
      if key==1
         g1=eval([filter '(gam,N,wb,wh)']); p=p+a(i)*g1;
      else
         if gam~=0, g1=eval([filter '(gam,N,wb,wh)']);
         else, g1=1; end
         p=p+a(i)*s^n1*g1;
end, end, end
