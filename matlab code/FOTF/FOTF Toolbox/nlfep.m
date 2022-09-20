function [y,t]=nlfep(fun,alpha,y0,tn,h,p,err)
% nlfec - O(h^p) predictor solution of nonlinear multi-term FODEs
%
%    [y,t]=nlfep(fun,alpha,y0,tn,h,p,err)
%
%   fun - function handles for the nonlinear explicit FODE
%   alpha - the maximum order
%   y0 - initial vector of the output and its integer-order derivatives
%   tn - terminate time in the solution
%   h - fixed step-size
%   p - the order for precision
%   err - error tolerance
%   y, t - the solution vector and time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 30 March, 2017 
% Last modified 18 May, 2022 
   arguments
      fun, alpha(1,:), y0(1,:), tn(1,1), h(1,1){mustBePositive}
      p(1,1) {mustBePositiveInteger}, err(1,1) double=1e-10
   end
   m=ceil(tn/h)+1; t=(0:(m-1))'*h; ha=h.^alpha; z=0;
   [T,dT,w,d2]=aux_func(t,y0,alpha,p); y=z+T(1); 
   for k=1:m-1
      zp=z(end); yp=zp+T(k+1); y=[y; yp]; z=[z; zp];
      [zc,yc]=repeat_funs(fun,t,y,d2,w,k,z,ha,dT,T);
      while abs(zc-zp)>err
         yp=yc; zp=zc; y(end)=yp; z(end)=zp;
         [zc,yc]=repeat_funs(fun,t,y,d2,w,k,z,ha,dT,T);
   end, end
% repeatedly called subfunction
   function [zc,yc]=repeat_funs(fun,t,y,d2,w,k,z,ha,dT,T)
      dy=zeros(1,d2-1);
      for j=1:(d2-1)
         dy(j)=w(1:k+1,j+1)'*z((k+1):-1:1)/ha(j+1)+dT(k,j+1);
      end, f=fun(t(k+1),y(k+1),dy);
      zc=((f-dT(k+1,1))*ha(1)-w(2:k+1,1)'*z(k:-1:1))/w(1,1); 
      yc=zc+T(k+1);
   end
end