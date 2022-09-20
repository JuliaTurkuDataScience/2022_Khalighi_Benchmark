function [Gc,x,y]=fpidtune(x0,xm,xM,kAlg)
% fpidtune - design of optimum fractional-order PID controllers
%
%   [Gc,x,y]=fpidtune(x0,xm,xM,kAlg)
%
%   x0 - initial parameters
%   xm, xM - boundary values of the decision variables
%   kAlg - optimization algorithm specifications
%   Gc - optimum FOPID controller
%   x - optimal decision variables
%   y - optimal value of the objective function

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   n=length(x0); if nargin==5, ff=optimset; ff.MaxIter=50; end
   switch kAlg
   case {1,2}
      x=fminsearchbnd(@fpidfuns,x0,xm,xM);
   case 3
      x=patternsearch(@fpidfuns,x0,[],[],[],[],xm,xM);
   case 4
      x=ga(@fpidfuns,n,[],[],[],[],xm,xM);
   case 5
      x=particleswarm(@fpidfuns,n,xm,xM);
   end
   [y,Gc]=fpidfuns(x);
end
