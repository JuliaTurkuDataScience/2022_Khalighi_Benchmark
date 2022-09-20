function H=freqw(p,w)
% freqw - get frequency response of ppoly object
%
%    H=freqw(p,w)
%
%   p - a ppoly object
%   w - frequency vector
%   H - frequency response data

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   for i=1:length(w), H(i)=p.a(:).'*(1i*w(i)).^p.na(:); end
end
