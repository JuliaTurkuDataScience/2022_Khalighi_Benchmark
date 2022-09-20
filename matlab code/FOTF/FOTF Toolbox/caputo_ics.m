function [c,y]=caputo_ics(a,na,b,nb,y0,u,t)
% caputo_ics - quivalent initial condition reconstruction, called by fode_caputo9

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   arguments, a(1,:), na(1,:), b(1,:), nb(1,:)
      y0(:,1), u(:,1), t(:,1)
   end
   na1=ceil(na); q=max(na1); K=length(t);
   p=K+q-1; d1=y0./gamma(1:q)';
   I1=1:q; I2=(q+1):p; X=zeros(K,p);
   for i=1:p, for k=1:length(a)
      if i>na1(k)
         X(:,i)=X(:,i)+a(k)*t.^(i-1-na(k))*gamma(i)/gamma(i-na(k));
   end, end, end
   u1=0; for i=1:length(b), u1=u1+b(i)*caputo9(u,t,nb(i),K-1); end
   X(1,:)=[]; u2=u1(2:end)-X(:,I1)*d1; d2=X(:,I2)\u2;
   c=[d1;d2]; y=0; for i=1:p, y=y+c(i)*t.^(i-1); end
end
