function strA=latex(p)
% latex - convert ppoly object into LaTeX string
%
%    str=latex(p)
%
%   p - a ppoly object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   str=disp(p); str=strrep(str,'*s','s'); 
   if nargout==0, disp(str), else, strA=str; end
end
