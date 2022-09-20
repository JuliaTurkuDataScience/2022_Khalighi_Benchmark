% foss - class constructor for an FOTF class

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
%Note that, the low-level support of FOTF object is changed to
%ppoly object, pseudo-polynomials
classdef fotf
   properties 
      num, den, ioDelay
   end    
   methods
     function G=fotf(a,na,b,nb,T)
     if isa(a,'fotf'), G=a; 
     elseif strcmp(class(a),'sym'), G=sym2fotf(a);    
     elseif isa(a,'foss'), G=foss2fotf(a);
     elseif nargin==1 && (isa(a,'tf') || isa(a,'ss') || isa(a,'double'))
        a=tf(a); [n1,m1]=size(a); G=[]; D=a.ioDelay;
        for i=1:n1, g=[]; for j=1:m1  
           [n,d]=tfdata(tf(a(i,j)),'v'); nn=length(n)-1:-1:0;
           nd=length(d)-1:-1:0; g=[g fotf(d,nd,n,nn,D(i,j))]; 
        end, G=[G; g]; end
     elseif nargin==1 && a=='s', G=fotf(1,0,1,1,0);
     elseif isa(a,'ppoly'), G.num=na; G.den=a; G.ioDelay=0;
     else, ii=find(abs(a)<eps); a(ii)=[]; na(ii)=[];
        ii=find(abs(b)<eps); b(ii)=[]; nb(ii)=[];
        if isempty(b), b=0; nb=0; end
        if nargin==4, T=0; end
        num=ppoly(b,nb); den=ppoly(a,na); G.num=num; G.den=den; G.ioDelay=T;
end, end, end, end