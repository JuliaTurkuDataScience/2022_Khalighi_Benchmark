function p1=mpower(p,n)
% mpower - power of a ppoly object
%
%    p1=p^n
%
%   p - a ppoly object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   if length(p.a)==1, p1=ppoly(p.a^n,p.na*n);
   elseif n==floor(n)
      if n<0, p.na=-p.na; n=-n; end
      p1=ppoly(1); for i=1:n, p1=p1*p; end
   else, error('n must be an integer'), end
end
