function str=latex(G)
% latex - convert an FOTF object into its LaTeX string
%
%   str=latex(G)
% 
%   G - an FOTF object
%   str - LaTeX string

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G);
   if n*m==1
      str=['\frac{' latex(G.num) '}{' latex(G.den) '}']; T= G.ioDelay; 
      if T~=0, ss=[]; if T~=1, ss=num2str(T); end
         str=[str '\mathrm{e}^{-' ss 's}']; 
      end
   else
      str='\begin{bmatrix}';
      for i=1:n
         for j=1:m
            str=[str, '\displaystyle ' latex(G(i,j)) '&'];
         end, str=[str(1:end-1) '\cr']; 
      end, str=[str(1:end-3),'\end{bmatrix}'];
   end
end
