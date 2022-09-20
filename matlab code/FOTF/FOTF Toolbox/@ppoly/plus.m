function p=plus(p1,p2)
% plus - sum of twp ppoly objects
%
%    p=p1+p2
%
%   p, p1, p2 - ppoly objects

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   p1=ppoly(p1); p2=ppoly(p2); 
   a=[p1.a,p2.a]; na=[p1.na,p2.na]; p=collect(ppoly(a,na));
end
