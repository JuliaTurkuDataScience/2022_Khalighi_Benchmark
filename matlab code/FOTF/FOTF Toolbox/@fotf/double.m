function a=double(G)
%double - convert FOTF to double, if possible

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 May, 2022 
   if G.num.na==0 && G.den.na==0
       a=G.num.a./G.den.a;
   else, error('G contains dynamic terms, cannot be converted into double')
   end  
end