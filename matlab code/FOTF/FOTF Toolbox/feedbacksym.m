function H=feedbacksym(G1,G2,key)
% feedbacksym finds the closed-form transfer function matrix

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022
   arguments, G1, G2, key(1,1)=-1; end
   G01=G1*G2; G02=G2*G1; [n1,m1]=size(G01); [n2,m2]=size(G02);
   if n1~=m1 || n2~=m2, error('Model sizes are incompatible'), end
   if n1<n2, H=inv(eye(n1)-key*G1*G2)*G1;
   else, H=G1*inv(eye(n1)-key*G2*G1); end
   if isa(H,'sym'), H=simplify(H); else, H=minreal(H); end
end
