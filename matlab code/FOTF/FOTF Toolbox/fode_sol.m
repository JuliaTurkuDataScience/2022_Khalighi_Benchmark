function y=fode_sol(a,na,b,nb,u,t)
% fode_sol - closed-form solution of FODE with zero initial conditions
%
%   y=fode_sol(a,na,b,nb,u,t)
%   
%   a,na,b,nb - coefficients/order vectors of numerator and denominator
%   u - the samples of the input signal
%   t - the time vector, corresponding to u
%   y - the solutions of the FODE, with O(h)

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      a(1,:), na(1,:), b(1,:), nb(1,:), u(:,1), t(:,1)
   end
   h=t(2)-t(1); D=sum(a./h.^na); nT=length(t);
   D1=b(:)./h.^nb(:); nA=length(a); vec=[na nb];
   y1=zeros(nT,1); W=ones(nT,length(vec));
   for j=2:nT, W(j,:)=W(j-1,:).*(1-(vec+1)/(j-1)); end
   for i=2:nT
      A=[y1(i-1:-1:1)]'*W(2:i,1:nA);
      y1(i,1)=(u(i)-sum(A.*a./h.^na))/D;
   end
   for i=2:nT, y(i,1)=(W(1:i,nA+1:end)*D1)'*y1(i:-1:1); end
end

