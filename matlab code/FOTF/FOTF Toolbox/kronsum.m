function C=kronsum(A,B)
% kronsum - evaluate the Kronecker sum of two matrices
%
%   C=kronsum(A,B)
%
%   A, B - the two matrices
%   C - the kronecker sum of matrices A and B
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [ma,na]=size(A); [mb,nb]=size(B);
   A=reshape(A,[1 ma 1 na]); B=reshape(B,[mb 1 nb 1]);
   C=reshape(A+B,[ma*mb na*nb]);
end
