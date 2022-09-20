function key=isppoly(p)
% isppoly - check whether input is an ppoly object
%
%    key=isppoly(p)
%
%   key returns 1 or 0

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   key=strcmp(class(p),'ppoly');
end