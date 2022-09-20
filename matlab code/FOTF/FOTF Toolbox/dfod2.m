function H=dfod2(n,T,r)
% DFOD2 - discrete implementation of s^r
%
%   H=dfod2(n,T,r)
%
%   n - filter order
%   T - sample time
%   r - fractional order
% modified directly from Petras function, under the same name
   arguments
      n(1,1) {mustBePositiveInteger}
      T(1,1) {mustBePositive}, r(1,1) double
   end
   if r>0
      bc=cumprod([1,1-((r+1)./[1:n])]); H=filt(bc,T^r,T);
   elseif r<0
      bc=cumprod([1,1-((-r+1)./[1:n])]); H=filt(T^(-r),bc,T);
end, end
