function [coefs,del]=fdcoef(m,p,alpha,t0)
% fdcoef - for computing finite difference coefficients
% see my book Vol2 

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 16 December, 2019
% Last modified 18 May, 2022
   arguments
      m(1,1){mustBePositiveInteger}, p(1,1){mustBePositiveInteger}
      alpha(1,:) {mustBeInteger}, t0(1,1){mustBeInteger}=0
   end
   m=m+1; del=sym(zeros(m,p,p)); del(1,1,1)=1; 
   c1=1; nm=min(p,m);
   for n=2:p, c2=1;
      for nu=1:n-1
         c3=alpha(n)-alpha(nu); c2=c2*c3; c4=1/c3;
         a0=alpha(n)-t0; del(1,n,nu)=c4*(a0*del(1,n-1,nu));
         for M=2:nm
            del(M,n,nu)=c4*(a0*del(M,n-1,nu)-(M-1)*del(M-1,n-1,nu));
      end, end
      a0=(alpha(n-1)-t0);
      del(1,n,n)=c1/c2*(-a0*del(1,n-1,n-1)); c4=c1/c2;
      for M=2:nm
         del(M,n,n)=c4*((M-1)*del(M-1,n-1,n-1)-a0*del(M,n-1,n-1));
      end, c1=c2;
   end
   coefs=del(m,p,:); coefs=coefs(:).';
end
