function G=matsuda_fod(G0,n,wb,wh)
% matsuda_fod - design of Matsuda-Fujii filter 
%
%   G=matsuda_fod(f,w)
%   G=matsuda_fod(gam,n,wb,wh)
%   G=matsuda_fod(G0,n,wb,wh)
%
%   f, w - the frequency response and frequency vector to be approximated
%   gam - the fractional order
%   G0 - the FOTF model to be fit
%   wb, wh, n - the frequency interval (wb,wh) and order of the filter
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, G0, n, wb(1,1)=1e-3, wh(1,1){mustBeGreaterThan(wh,wb)}=1e3, end
   if nargin==2, f=G0; w=n; n=length(w);
   else, if isa(G0,'double'), s=fotf('s'); G0=s^G0; end 
      w=logspace(log10(wb),log10(wh),n); f=mfrd(G0,w); 
   end
   v=abs(f(:).'); s=tf('s'); n=length(w);
   for k=1:n, a(k)=v(k); v=(w-w(k))./(v-v(k)); end
   G=a(n); for k=n-1:-1:1, G=a(k)+(s-w(k))/G; end
end
