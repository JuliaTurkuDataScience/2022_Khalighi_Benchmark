function [y,t]=nlfec(fun,alpha,y0,yp,t,p,err)
% nlfec - O(h^p) corrector solution of nonlinear multi-term FODEs
%
%    [y,t]=nlfec(fun,alpha,y0,yp,t,p,err)
%
%   fun - function handles for the nonlinear explicit FODE
%   alpha - the maximum order
%   y0 - initial vector of the output and its integer-order derivatives
%   yp - predictor solutions
%   t - time vector
%   p - the order for precision
%   err - error tolerance
%   y - the solution vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 30 March, 2017 
% Last modified 18 May, 2022 
   arguments
      fun, alpha(1,:), y0(:,1), yp(:,1), t(:,1)
      p(1,1){mustBePositiveInteger}, err(1,1) double=1e-10
   end
   h=t(2)-t(1); m=length(t); ha=h.^alpha;
   [T,dT,w,d2]=aux_func(t,y0,alpha,p);
   [z,y]=repeat_funs(fun,t,yp,T,d2,alpha,dT,ha,w,m,p);
   while norm(z)>err, yp=y; z=zeros(m,1);
      [z,y]=repeat_funs(fun,t,yp,T,d2,alpha,dT,ha,w,m,p);
   end
   % repeatedly called subfunction
   function [z,y]=repeat_funs(fun,t,yp,T,d2,alpha,dT,ha,w,m,p)
      for i=1:d2
         dyp(:,i)=glfdiff9(yp-T,t,alpha(i),p)+dT(:,i); 
      end
      f=fun(t,yp,dyp(:,2:d2))-dyp(:,1); y=yp; z=zeros(m,1);
      for i=2:m, ii=(i-1):-1:1;
         z(i)=(f(i)*(ha(1))-w(2:i,1)'*z(ii))/w(1,1); 
         y(i)=z(i)+yp(i);
   end, end
end
