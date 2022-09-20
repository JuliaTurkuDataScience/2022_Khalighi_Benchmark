function y=fode_sol9(a,na,b,nb,u,t,p)
% fode_sol9 - high precision solution of FODE with zero initial conditions
%
%   y=fode_sol(a,na,b,nb,u,t)
%   
%   a,na,b,nb - coefficients/order vectors of numerator and denominator
%   u - the samples of the input signal
%   t - the time vector, corresponding to u
%   p - the order of precision O(h^p)
%   y - the solutions of the FODE, with O(h^p)

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      a(1,:), na(1,:), b(1,:), nb(1,:), u(:,1), t(:,1)
      p(1,1) {mustBePositiveInteger}=5
   end
   h=t(2)-t(1); n=length(t); vec=[na nb]; 
   g=double(genfunc(p)); W=[];
   for i=1:length(vec), W=[W; get_vecw(vec(i),n,g)]; end
   D1=b./h.^nb; nA=length(a); y1=zeros(n,1);
   W=W.'; D=sum((a.*W(1,1:nA))./h.^na); 
   for i=2:n 
      A=[y1(i-1:-1:1)]'*W(2:i,1:nA);  
      y1(i)=(u(i)-sum(A.*a./h.^na))/D;
   end
   for i=2:n, y(i,1)=(W(1:i,nA+1:end)*D1)'*y1(i:-1:1); end
end

