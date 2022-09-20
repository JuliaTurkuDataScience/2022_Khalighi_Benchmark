function G=charef_fod(alpha,pT,delta,wM)
% charef_fod - design function for the Charef filter
%
%   H=charef_fod(alpha,pT,delta,wM)
%   
%   alpha - the fractional order
%   pT - the turning frequency
%   delta - the error tolerance in dBs
%   wM - maximum frequency
%   H - the Charef filter designed

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last Modified 18 May, 2022
   arguments
      alpha(1,1)double, pT(1,1)double, delta(1,1)double, wM(1,1)double
   end
   p0=pT*10^(delta/20/alpha);
   a=10^(delta/10/(1-alpha)); b=10^(delta/10/alpha);
   n=ceil(log(wM/p0)/log(a*b)); ii=1:n; p=p0*(a*b).^ii;
   p=[p0 p]; z=a*p(1:n); K=prod(p)/prod(z); G=zpk(-z,-p,K);
end
