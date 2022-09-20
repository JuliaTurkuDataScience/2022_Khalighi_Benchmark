function [y,t]=nlfode_mat(f,alpha,y0,tn,h,p,yp)
% nlfode_mat - O(h^p) predictor solution of nonlinear single-term FODEs
%
%    [y,t]=nlfode_mat(f,alpha,y0,tn,h,p,yp)
%
%   f - function handles for the nonlinear explicit FODE
%   alpha - the maximum order
%   y0 - initial vector of the output and its integer-order derivatives
%   tn - terminate time in the solution
%   h - fixed step-size
%   p - the order for precision
%   yp - the predictor solution
%   y, t - the solution vector and time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      f, alpha(1,:) double, y0(:,1) double, tn(1,1) double
      h(1,1){mustBePositive}, p(1,1){mustBePositiveInteger}
      yp(:,1) double=zeros(ceil(tn/h)+1,1);
   end
   alfn=ceil(alpha); m=ceil(tn/h)+1;
   t=(0:(m-1))'*h; d1=length(y0); d2=length(alpha);
   B=zeros(m,m,d2); g=double(genfunc(p));
   for i=1:d2, w=get_vecw(alpha(i),m,g);
      B(:,:,i)=rot90(hankel(w(end:-1:1)))/h^alpha(i);
   end
   c=y0./gamma(1:d1)'; du=zeros(m,d2);
   u=0; for i=1:d1, u=u+c(i)*t.^(i-1); end
   for i=1:d2
      if alfn(i)==0, du(:,i)=u;
      elseif alfn(i)<d1
         for k=(alfn(i)+1):d1
            du(:,i)=du(:,i)+(t.^(k-1-alpha(i)))*c(k)...
                    *gamma(k)/gamma(k-alpha(i));
   end, end, end
   v=fsolve(f,yp,[],t,u,B,du); y=u+v;
end
