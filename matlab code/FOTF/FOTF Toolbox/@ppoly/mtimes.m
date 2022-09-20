function p=mtimes(p1,p2)
% mtimes - product of two ppoly objects
%
%    p=p1*p2
%
%   p, p1, p2 - ppoly object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   p1=ppoly(p1); p2=ppoly(p2); a=kron(p1.a,p2.a); 
   na=kronsum(p1.na,p2.na); p=collect(ppoly(a,na));
end
