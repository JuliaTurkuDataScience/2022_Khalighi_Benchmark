function [x,t]=nlfode_vec(f,alpha,x0,h,tn,L0)
% nlfode_vec - O(h^p) predictor solution of nonlinear single-term FODEs
%
%    [x,t]=nlfode_vec(f,alpha,x0,h,tn,L0)
%
%   f - function handles for the nonlinear explicit FODE
%   alpha - the maximum order
%   x0 - initial state vector
%   h - fixed step-size
%   tn - terminate time in the solution
%   L0 - the memory length for short-memory principle
%   x, t - the solution matrix for the states and time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      f, alpha(1,:), x0(:,1), h(1,1){mustBePositive}
      tn(1,1){mustBePositive}, L0(1,1){mustBePositive}=1e20;
   end
   n=length(x0); m=round(tn/h)+1; t=0; g=double(genfunc(1));
   ha=h.^alpha; z=zeros(n,m); x1=x0;
   for i=1:n, W(i,:)=get_vecw(alpha(i),min(m,L0+1),g); end
   for k=2:m, tk=(k-1)*h; L=min(k-1,L0);
      for i=1:n
         x1(i)=f(tk,x1,i)*ha(i)-W(i,2:L+1)*z(i,k-1:-1:k-L).'+x0(i);
      end
      t=[t,tk]; z(:,k)=x1-x0;
   end
   x=(z+repmat(x0,[1,m])).'; t=t(:);
end
