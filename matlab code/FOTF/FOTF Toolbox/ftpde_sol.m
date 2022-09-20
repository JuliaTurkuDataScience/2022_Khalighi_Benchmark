function [U,X,T]=ftpde_sol(a,f,alpha,L,T0,phi1,phi2,psi1,psi2,m,n)
% ftpde_sol - numerical solutions of time-fractional PDE
%
% Equation u^alpha_t=a*u_xx+f, x0<=x<=uX, t0<=t<=uT
%
% For details see the book

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   arguments
      a(1,1) double, f, alpha(1,1){mustBePositive}
      L(1,:) double, T0(1,:) double
      phi1(1,1), phi2, psi1(1,1), psi2(1,1)
      m(1,1){mustBeInteger}=100; n(1,1){mustBeInteger}=100; 
   end
   if isscalar(L), L=[0,L]; end, dx=(L(2)-L(1))/m; 
   if isscalar(T0), T0=[0,T0]; end, dt=(T0(2)-T0(1))/n;
   x=L(1)+(0:m)'*dx; t=T0(1)+(0:n)'*dt;
   [T,X]=meshgrid(t,x); F=f(X,T);
   r=a*(dt^alpha)/dx/dx; U=zeros(m+1,n+1); v=phi1(x); V=v; I=2:m;
   if alpha>1, v1=phi2(x)*dt; V=[V zeros(m+1,n)]; end
   if alpha>1, for i=1:n, v=v+v1; V(:,i+1)=v; end, end
   if alpha>1, dV=zeros(m+1,n+1);  
      for j=2:n+1, dV(I,j)=r*V(I-1,j)-2*r*V(I,j)+r*V(I+1,j); end
   else, dV(I)=r*V(I-1)-2*r*V(I)+r*V(I+1); dV=[dV(:); 0]; end
   F=F*(dt^alpha)+dV; r0=r*ones(m-2,1); 
   g=genfunc(1); w=get_vecw(alpha,n+1,double(g))';
   A0=(2*r+1)*eye(m-1)-diag(r0,1)-diag(r0,-1); A0=inv(A0); 
   U(1,:)=psi1(t)-V(1,:)'; U(m+1,:)=psi2(t)-V(m+1,:)'; 
   for j=1:n
      b1=[r*U(1,j+1); zeros(m-3,1); r*U(m+1,j+1)]; 
      b1=b1-U(2:m,1:j)*w(j+1:-1:2)+F(2:m,j+1);
      U(2:m,j+1)=A0*b1; % use predefined inverse for multiplication
   end
   U=U+V; % fund the solution matrix
end

