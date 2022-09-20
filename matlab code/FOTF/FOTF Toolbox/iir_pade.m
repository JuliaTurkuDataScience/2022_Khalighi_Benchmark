function H=iir_pade(r,a,n,T)
% iir_pade - design IIR filter with Pade approximants  
%
%   H=iir_pade(r,a,n,T)
%
%   r - the fractional order
%   a - weighting factor
%   n - the filter order
%   T - sample time
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   arguments, r(1,1) double, a(1,1){mustBeInRange(a,0,1)}=0
      n(1,1){mustBePositiveInteger}=3
      T(1,1){mustBePositive}=0.01
   end
   syms x, b=(3+a-2*sqrt(3*a))/(3-a); 
   k0=6*b/T/(3-a); f=((1-x^2)/(1+b*x)^2)^r;
   c=taylor(f,x,'Order',2*n); c=sym2poly(c);
   c=c(end:-1:1); [N,D]=padefcn(c,n-1,n);
   H=k0^r*tf(N(end:-1:1),D(end:-1:1),'Variable','z^-1','Ts',T);
end
