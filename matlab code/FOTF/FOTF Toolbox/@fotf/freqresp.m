function H=freqresp(s,G1)
% freqresp - low-level function to evaluate the frequency response of
%            an FOTF object
%
%   H=freqresp(s,G)
% 
%   s - the frequency vector or a vector for s
%   G - the FOTF object
%   H - frequency response, i.e., G(s) vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G1); 
   for i=1:n, for j=1:m
      [a,na,b,nb,L]=fotfdata(G1(i,j)); 
      for k=1:length(s)
         P=b*(s(k).^nb.'); Q=a*(s(k).^na.'); H1(k)=P/Q; 
      end
      if L>0, H1=H1.*exp(-L*s); end, H(i,j,:)=H1; 
   end, end
   if n*m==1, H=H(:).'; end
end
