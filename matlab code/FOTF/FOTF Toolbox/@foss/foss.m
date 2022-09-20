% foss - class constructor for an FOSS class

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
classdef foss
   properties, a, b, c, d, alpha, ioDelay, E, x0, end
   methods
     function G=foss(a,b,c,d,alpha,L,E,x0)
        if nargin<=7, x0=[]; end
        if nargin<=6, E=[]; end, if nargin<=5, L=0; end
        if nargin==1 && isa(a,'foss'), G=a;
        elseif nargin==1 && isa(a,'fotf'), G=fotf2foss(a);
        elseif nargin==1 && isa(a,'double'), G=foss([],[],[],a,0);
        elseif (nargin==1||nargin==2) && (isa(a,'tf')||isa(a,'ss'))
           alpha=1; if nargin==2, alpha=b; end 
           a=ss(a); L=a.ioDelay; [a,b,c,d,E]=dssdata(a); 
           G=foss(a,b,c,d,alpha,L,E);
        elseif nargin>=5, msg=abcdchk(a,b,c,d);
           if length(msg)>0, error(msg)
           else, G.alpha=alpha; G.x0=x0;
              G.a=a; G.b=b; G.c=c; G.d=d; G.E=E; G.ioDelay=L;
           end
        else, error('wrong input arguments'); end
end, end, end
