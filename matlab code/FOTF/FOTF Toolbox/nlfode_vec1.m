function [x,t]=nlfode_vec1(f,alpha,x0,h,tn,L0)
% nlfode_vec - another version of nlfode_vec, not recommended

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      f, alpha(1,:), x0(:,1), h(1,1), tn(1,1), L0(1,1)=1e20;
   end
   n=length(x0); m=round(tn/h)+1; t=0; g=double(genfunc(1));
   x1=x0; ha=h.^alpha(:); z=zeros(n,m); tk=0;
   for i=1:n, W(i,:)=get_vecw(alpha(i),min(m,L0+1),g); end
   for k=2:m, tk=(k-1)*h; L=min(k-1,L0);
      for i=1:n, F0(i,1)=W(i,2:L+1)*z(i,k-1:-1:k-L).'-x0(i); end
      F=@(x)x-f(tk,x).*ha+F0;
      x1=fsolve(F,x1); t=[t; tk]; z(:,k)=x1-x0;
   end
   x=(z+repmat(x0,[1,m])).'; 
end
