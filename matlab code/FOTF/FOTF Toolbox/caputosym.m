function dy=caputosym(f,alpha,t0,t)
%caputosym evaluates symbolically Caputo derivatives
%
%    dy=caputosym(f,alpha,t0,t)
%
%    f - symbolic expression or symbolic function 
%    alpha - fractional order, must be a symbolic number
%    t0 - initial time, default of 0
%    t - final time, woth default of symbolic t

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   arguments, f(1,1), alpha(1,1), t0(1,1)=0, t(1,1)=symvar(f), end
   if alpha<=0, dy=riemannsym(f,alpha,t0,t); return; end
   syms tau; alpha=sym(alpha); m=ceil(alpha); gam=m-alpha;
   switch class(f)
      case 'sym', F=diff(subs(f,t,tau),m);
      case 'symfun', F=diff(f(tau),m);
      otherwise, error('f must be a symbolic expression')
   end
   dy=1/gamma(gam)*int(F/(t-tau)^(1-gam),tau,t0,t);
end
