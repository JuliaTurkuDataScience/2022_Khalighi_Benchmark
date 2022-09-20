function f=ml_func(aa,z,n,eps0)
% ml_func - numeric computation of Mittag-Leffler functions and derivatives
%
%   f=ml_func(alpha,z)
%   f=ml_func([alpha,beta],z)
%   f=ml_func([alpha,beta,gamma],z)
%   f=ml_func([alpha,beta,gamma,q],z)
%   f=ml_func(pars,z,n)
%   f=ml_func(pars,z,n,eps0)
%   
%   alpha, beta, gamma, q - the parameters for Mittag-Leffler functions
%   z - the independent variable samples in a vector
%   n - the integer-order for derivatives of Mittag-Leffler functions
%   eps0 - the error tolerance
%   f - the numerical samples of Mittag-Leffler function or derivatives
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      aa(1,:) double, z double
      n(1,1) {mustBeNonnegativeInteger}=0, eps0(1,1)=eps; 
   end
   aa=[aa,1,1,1]; a=aa(1); b=aa(2); c=aa(3); q=aa(4);
   f=0; k=0; fa=1;
   if n==0                     
      while norm(fa,1)>=eps0   
         fa=prod(c:(c+q*k-1))/gamma(k+1)/gamma(a*k+b)*z.^k;
         f=f+fa; k=k+1;
      end
      if ~isfinite(f)      
        if c*q==1, N=round(-log10(eps0));
           f=mlf(a,b,z(:),N); f=reshape(f,size(z));
        else, error('Error: truncation method failed'); end, end
   else
      aa(2)=aa(2)+n*aa(1); aa(3)=aa(3)+aa(4)*n;    
      f=prod(c:(c+q*k-1))*ml_func(aa,z,0,eps0); 
end, end
