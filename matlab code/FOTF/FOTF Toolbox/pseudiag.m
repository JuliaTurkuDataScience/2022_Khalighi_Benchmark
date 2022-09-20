function Kp=pseudiag(G1,R)
% pseudiag - design of pseudodiagonalisation matrix
%
%    Kp=pseudiag(G1,R)
%
%   G1 - frequency response of the multivariable plant model, in MFD format
%   R - weighting in the responses, optional
%   Kp - the pre-compensator matrix

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
A=real(G1); B=imag(G1); [n,m]=size(G1); N=n/m; Kp=[];
if nargin==1, R=ones(N,1); end
for q=1:m, L=1:m; L(q)=[];
   for i=1:m, for l=1:m, a=0;
      for r=1:N, k=(r-1)*m;
         a=a+R(r)*sum(A(k+i,L).*A(k+l,L)+B(k+i,L).*B(k+l,L));
      end,
      Ap(i,l)=a;
   end, end
   [x,d]=eig(Ap); [xm,ii]=min(diag(d)); Kp=[Kp; x(:, ii)'];
end
