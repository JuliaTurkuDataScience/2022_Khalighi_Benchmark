function [T,dT,w,d2]=aux_func(t,y0,alpha,p)
% aux_func - auxilliary function, not recommended to call directly

% Copyright (c) Dingyu Xue, Northeastern University, China
% Created  28 March, 2017
% Last Modified 18 May, 2022
   an=ceil(alpha); y0=y0(:); q=length(y0); d2=length(alpha);
   m=length(t); g=double(genfunc(p));
   for i=1:d2, w(:,i)=get_vecw(alpha(i),m,g)'; end
   b=y0./gamma(1:q)'; T=0; dT=zeros(m,d2);
   for i=1:q, T=T+b(i)*t.^(i-1); end
   for i=1:d2
      if an(i)==0, dT(:,i)=T;
      elseif an(i)<q
         for j=(an(i)+1):q
            dT(:,i)=dT(:,i)+(t.^(j-1-alpha(i)))*...
                  b(j)*gamma(j)/gamma(j-alpha(i));
end, end, end, end
