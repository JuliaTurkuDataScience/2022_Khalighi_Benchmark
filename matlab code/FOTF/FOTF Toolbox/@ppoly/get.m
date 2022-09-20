function p1=get(varargin)
% get - get fields from ppoly object
%
%    a=get(p,'a') or na=get(p,'na') 

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   p=varargin{1};
   if nargin==1 
       s=sprintf('%f ,',p.a); disp(['  a: [' s(1:end-1) ']'])
       s=sprintf('%f ,',p.na); disp([' na: [' s(1:end-1) ']'])
   elseif nargin==2, key=varargin{2};
       switch key 
           case 'a', p1=p.a; case 'na', p1=p.na;
           otherwise, error('Wrong field name used'), 
       end
   else, error('Wrong number of input argumants'); 
   end
end