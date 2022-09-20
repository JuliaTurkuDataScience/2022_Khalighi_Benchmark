function Gc=fopid(Kp,Ki,Kd,lam,mu0,T) 
% fopid - construct FOPID controller from given parameters
%
%   Gc=fopid(Kp,Ki,Kd,lam,mu0)
%   
%   Kp,Ki,Kd,lam,mu0 - the FOPID parameters
%   Gc - the composed FOPID controller

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   s=fotf('s');
   if length(Kp)~=1, Kp=[Kp,0]; else, if nargin==5, T=0; end, end  
   if length(Kp)==1, Gc=Kp+Ki*s^(-lam)+Kd*s^mu0/(T*s+1);
   else, x=Kp; Gc=x(1)+x(2)*s^(-x(4))+x(3)*s^(x(5))/(x(6)*s+1); end
end
