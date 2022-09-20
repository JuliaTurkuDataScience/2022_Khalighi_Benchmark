% ppoly - class definition of a ppoly object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
classdef ppoly
   properties, a, na, end
   methods
     function p=ppoly(a,na)
     if nargin==1
        if isa(a,'double'), p=ppoly(a,length(a)-1:-1:0);
        elseif isa(a,'ppoly'), p=a;  
        elseif a=='s', p=ppoly(1,1); end
     elseif length(a)==length(na), p.a=a; p.na=na;
     else, error('Error: miss matching in a and na'); end
end, end, end
