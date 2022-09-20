function P=ppoly2sym(p,s)
% ppoly2sym - convert ppoly object to symbolic expression
%
%    P=ppoly2sym(p,s)
%
%   p - a ppoly object
%   s - a symbolic variable

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   arguments, p(1,1), s(1,1)=sym('s'); end
   p=collect(p); n=length(p.a); P=sym(0);
   for i=1:n, P=P+p.a(i)*s^(p.na(i)); end
end
