function [y,t]=pepc_nlfode(f,alpha,y0,h,tn,err,key)
% pepc_nlfode - numerical solution of nonlinear single-term FODEs
%
%    [y,t]=pepc_nlfode(f,alpha,y0,h,tn,err,key)
%
%   f - function handles for the nonlinear explicit FODE
%   alpha - the maximum order
%   y0 - initial vector of the output and its integer-order derivatives
%   h - fixed step-size
%   tn - terminate time in the solution
%   err - error tolerance
%   key - identifier, 0 for with predictor, 1 for bypass predictor, 
%         2 for predictor alone 
%   y, t - the solution vector and time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      f, alpha(1,1), y0, h(1,1), tn(1,1){mustBePositive}, 
      err(1,1)=1e-6; key{mustBeMember(key,1:3)}=0
   end
   t=0; y1=y0; q=ceil(alpha); a1=alpha+1; m=round(tn/h);
   K=h^alpha/alpha/a1; Ga=1/gamma(alpha);
   y=[y1 zeros(size(y0,1),m)]; n=length(y1);
   for k=0:m-1, tk1=t(end)+h; t=[t,tk1]; ii=0:k; y01=0;
      for i=1:q,y01=y01+tk1^(i-1)/factorial(i-1)*y0(:,i); end
      if key==1, yp=y(:,k+1);
      else, yp=y01;
         b=h^alpha/alpha*((k+1-ii).^alpha-(k-ii).^alpha);
         for i=0:k, yp=yp+b(i+1)*f(t(i+1),y(:,i+1))*Ga; end
      end
      if key~=2
         ii=1:k; a2=(k-ii+2).^a1+(k-ii).^a1-2*(k-ii+1).^a1;
         a0=k^a1-(k-alpha)*(k+1)^alpha; a=[a0 a2 1]*K;
         while (1), y1=y01+a(k+2)*f(tk1,yp)*Ga;
            for i=0:k, y1=y1+a(i+1)*f(t(i+1),y(:,i+1))*Ga; end
            if (norm(y1-yp)<err||(key==0&&n==1)||key==3), break;
            else, yp=y1; end
         end
      else, y1=yp; end, y(:,k+2)=y1;
   end, y=y'; t=t(:);
end
