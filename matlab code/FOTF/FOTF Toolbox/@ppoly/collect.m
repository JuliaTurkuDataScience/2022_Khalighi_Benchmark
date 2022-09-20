function p=collect(p) 
% collect - collect like terms in ppoly objects
%
%    p=collect(p)
%
%   p - a ppoly object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   a=p.a; na=p.na; 
   [na,ii]=sort(na,'descend'); a=a(ii); ax=diff(na); key=1;
   for i=1:length(ax)
      if abs(ax(i))<=1e-10
         a(key)=a(key)+a(key+1); a(key+1)=[]; na(key+1)=[];
      else, key=key+1; end
   end
   ii=find(abs(a)~=0); a=a(ii); na=na(ii); p=ppoly(a,na);
end
