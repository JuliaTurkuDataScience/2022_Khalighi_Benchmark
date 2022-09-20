function G1=sym2fotf(G)
% sym2fotf convert symbolic expression to FOTF matrix

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   [n,m]=size(G); G1=fotf(zeros(n,m));
   for i=1:n, for j=1:m
      [num,den]=numden(G(i,j)); 
      G1(i,j)=fotf(sym2ppoly(den),sym2ppoly(num));
end, end, end
function p1=sym2ppoly(p)
   syms s real; [C,T]=coeffs(p); T=log(T)/log(s); T=simplify(subs(T,s,2)); 
   p1=ppoly(double(C),double(T));
end