function p=mrdivide(p1,p2)
% mrdivide - right divide ppoly objects
%
%    p=p1/p2
%
%   p, p1, p2 - ppoly objects

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   p1=collect(ppoly(p1)); p2=collect(ppoly(p2)); p=fotf(p2,p1);
end
