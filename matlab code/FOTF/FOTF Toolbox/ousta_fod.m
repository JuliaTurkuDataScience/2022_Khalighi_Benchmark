function G=ousta_fod(gam,N,wb,wh)
% ousta_fod - design of an Oustaloup filter
%
%    G=ousta_fod(r,N,wb,wh)
%
%   r - the fractional order
%   wb, wh, N - the interested frequency interval (wb,wh) and the order
%   G - the designed Oustaloup filter, as a TF object
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      gam(1,1) double, N(1,1){mustBePositiveInteger}=9
      wb(1,1) double=1e-4; wh(1,1){mustBeGreaterThan(wh,wb)}=1e4;
   end
   if round(gam)==gam, G=tf('s')^gam;
   else
      k=1:N; wu=sqrt(wh/wb);
      wkp=wb*wu.^((2*k-1-gam)/N); wk=wu^(2*gam/N)*wkp;
      G=zpk(-wkp,-wk,wh^gam);
end, end
