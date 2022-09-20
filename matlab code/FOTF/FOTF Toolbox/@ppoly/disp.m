function str=disp(p)
% collect - collect like terms in ppoly objects
%
%    p=collect(p)
%
%   p - a ppoly object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   np=p.na; p=p.a; 
   if isempty(np), p=0; np=0; end
   P=''; [np,ii]=sort(np,'descend'); p=p(ii); 
   for i=1:length(p)
      P=[P,'+',num2str(p(i)),'*s^{',num2str(np(i)),'}'];
   end
   P=P(2:end); P=strrep(P,'s^{0}',''); P=strrep(P,'+-','-'); 
   P=strrep(P,'^{1}',''); P=strrep(P,'+1*s','+s'); 
   P=strrep(P,'*+','+'); P=strrep(P,'*-','-');
   P=strrep(P,'-1*s','-s'); nP=length(P); 
   if nP>=3 && isequal(P(1:3),'1*s'), P=P(3:end); end
   if P(end)=='*', P(end)=''; end 
   if nargout==0, disp(P), else, str=P; end
end
