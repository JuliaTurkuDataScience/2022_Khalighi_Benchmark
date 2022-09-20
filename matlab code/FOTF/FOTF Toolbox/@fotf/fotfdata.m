function [a,na,b,nb,L]=fotfdata(G)
% fotfdata - extract data from an FOTF object
%
%   [a,na,b,nb,L]=fotfdata(G)
% 
%   G - an FOTF object
%   [a,na,b,nb] - the coefficients and orders of denominator and numerator
%   L - the delay constant

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G);
   if n*m==1, b=G.num.a; a=G.den.a; nb=G.num.na; na=G.den.na; L=G.ioDelay;
   else
      for i=1:n, for j=1:m
         [a0,na0,b0,nb0,L0]=fotfdata(G(i,j)); 
         a{i,j}=a0; b{i,j}=b0; na{i,j}=na0; nb{i,j}=nb0; L(i,j)=L0;
end, end, end, end      
