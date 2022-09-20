function y=fode_solm(a,na,b,nb,u,t)
% fode_solm - matrix version of fode_sol, with the same syntax

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, a(1,:), na(1,:), b(1,:), nb(1,:), u(:,1), t(:,1), end
   h=t(2)-t(1); u=u(:); A=0; B=0; g=double(genfunc(1));
   nt=length(t); n=length(a); m=length(b);
   for i=1:n, A=A+get_vecw(na(i),nt,g)*a(i)/(h^na(i)); end
   for i=1:m, B=B+get_vecw(nb(i),nt,g)*b(i)/(h^nb(i)); end
   A=rot90(hankel(A(end:-1:1)));
   B=rot90(hankel(B(end:-1:1))); y=B*(A\u);
end
