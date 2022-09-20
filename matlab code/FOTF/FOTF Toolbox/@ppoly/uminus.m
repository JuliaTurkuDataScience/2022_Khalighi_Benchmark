function p1=uminus(p)
% uminus - find -p
%
%    p1=-p
%
%   p, p1 - ppoly objects

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   p1=ppoly(-p.a,p.na);
end
