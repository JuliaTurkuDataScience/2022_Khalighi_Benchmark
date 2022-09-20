function G1=foss2fotf(G)
% foss2fotf - convert an FOSS object to FOTF one
%
%   G1=foss2fotf(G)
% 
%   G - an FOSS object
%   G1 - an equivalent FOTF object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); G1=fotf(zeros(n,m));
   G0=ss_extract(G); G0=tf(G0); key=length(G.alpha)>1;
   T=G.ioDelay; if isscalar(T), T=T*ones(n,m); end  
   if key~=0
      n0=G.alpha; n1=n0(end:-1:1); n2=0;
      for i=1:length(n1), n2(i+1)=n2(i)+n1(i); end
      n2=n2(end:-1:1);
   end
   for i=1:n, for j=1:m, g=G0(i,j);
      [num,den]=tfdata(g,'v');
      if key==0, n2=((length(den)-1):-1:0)*G.alpha; end
      h=fotf(den,n2,num,n2,T(i,j)); h=simplify(h); G1(i,j)=h;
end, end, end
