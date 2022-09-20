function G=new_fod(r,N,wb,wh,b,d)
% new_fod - design of a modified Oustaloup filter
%
%    G=new_fod(r,N,wb,wh)
%
%   r - the fractional order
%   wb, wh, N - the interested frequency interval (wb,wh) and the order
%   G - the designed modified Oustaloup filter, as a TF object
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments
      r(1,1) double, N(1,1){mustBePositiveInteger}=5
      wb(1,1) double=1e-3; wh(1,1) double=1e3;
      b(1,1) {mustBeNumeric}=10; d(1,1) {mustBeNumeric}=9;
   end
   G=(d/b)^r*tf([d,b*wh,0],[d*(1-r),b*wh,d*r]);
   G=G*ousta_fod(r,N,wb,wh);
end