function sigma(G,w)
% sigma - singular value plots of a MIMO FOTF object
%
%   sigma(G,w)
% 
%   G - a MIMO FOTF object
%   w - a frequency vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargin==1, w=logspace(-4,4); end
   H=bode(G,w); subplot(111); h1=[]; H1=H;
   h=H.ResponseData; [n,m,k]=size(h);
   for i=1:k, h1=[h1, svd(h(:,:,i))]; end
   for i=1:min([n,m]) 
      h2(1,1,:)=h1(i,:).'; H1.ResponseData=h2; bodemag(H1), hold on
   end
   hold off
end
