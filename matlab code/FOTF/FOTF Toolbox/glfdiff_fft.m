function dy=glfdiff_fft(y,t,gam,p)
% glfdiff_fft - evaluation of O(h^p) GL derivatives with FFT, not recommended 
%
%   dy=glfdiff_fft(y,t,gam,p)
%
%   y - the samples of the function handle of the original function
%   t - the time vector
%   gam - the fractional order
%   p - the order for the precision setting
%   dy - the fractional-order derivatives, or integrals if gam<0
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, y(:,1), t(:,1), gam(1,1)
      p(1,1){mustBePositiveInteger}=5
   end
   [y,h,n]=fdiffcom(y,t); dy=zeros(n,1); 
   g=double(genfunc(p)); T=2*pi/(n-1);
   if y(1)~=0 && gam>0, dy(1)=sign(y(1))*Inf; end
   tt=0:T:2*pi; F=g(1); f1=exp(1i*tt); f0=f1;
   for i=2:p+1, F=F+g(i)*f1; f1=f1.*f0; end
   w=real(fft(F.^gam))*T/2/pi;
   for k=2:n, dy(k)=w(1:k)*y(k:-1:1)/h^gam; end
end
