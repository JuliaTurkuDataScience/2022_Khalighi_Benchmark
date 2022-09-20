function dy=riemannsym(f,alpha,t0,t)
% riemannsym Symbolic computing of Roemann-Liouville derivatives

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   arguments, f(1,1), alpha(1,1), t0(1,1)=0, t(1,1)=symvar(f), end
   syms tau; alpha=sym(alpha); 
   switch class(f)
      case 'sym', F=subs(f,t,tau);
      case 'symfun', F=f(tau);
      otherwise, error('f must be a symbolic expression')
   end
   if alpha<0, alpha=-alpha;
      dy=1/gamma(alpha)*int(F/(t-tau)^(1-alpha),tau,t0,t);
   elseif alpha==0, dy=f;
   else, n=ceil(alpha);
      f1=int(F/(t-tau)^(1+alpha-n),tau,t0,t);
      dy=diff(f1,t,n)/gamma(n-alpha);
   end
end
