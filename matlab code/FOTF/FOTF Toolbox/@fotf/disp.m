function str=disp(G)
% display - display an FOTF.  This function will be called automatically

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); key=0; if nargout==1, key=1; end
   for i=1:m, if m>1, disp(['   From input ' int2str(i) ' to output...']), end
      for j=1:n, if n>1, disp(['   ' int2str(j) ':']), end
         str=fotfdisp(G(j,i),key); if nargout==0, disp(' '); end
end, end, end
%  display a SISO FOTF object
function str=fotfdisp(G,key)
   strN=disp(G.num); str=strN; 
   strD=disp(G.den); nn=length(strN); 
   if nn==1 && strN=='0', if key==0, disp(strN), end
   else, nd=length(strD); nm=max([nn,nd]);
      if key==0, disp([char(' '*ones(1,floor((nm-nn)/2))) strN]), end
      ss=[]; T=G.ioDelay; if T>0, ss=['exp(-' num2str(T) '*s)']; end
      if T>0, str=['(' str ')*' ss '/(' strD ')']; 
      else, str=['(' str ')/(' strD ')']; end
      str=strrep(strrep(str,'{',''),'}','');
      if key==0, disp([char('-'*ones(1,nm)), ss]);
         disp([char(' '*ones(1,floor((nm-nd)/2))) strD])
end, end, end
