function more_sols(f,X0,A,tol,tlim,ff)
% morw_sols - find multiple solutions of a matrix equation

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   arguments, f, X0, A=1000, tol=eps, tlim=10, ff=optimset; end
   X=X0; if length(A)==1, a=-0.5*A; b=0.5*A; else, a=A(1); b=A(2); end
   ar=real(a); br=real(b); ai=imag(a); bi=imag(b); [n,m,i]=size(X0);
   ff.Display='off'; ff.TolX=tol; ff.TolFun=1e-20; tic
   if i==0, X0=zeros(n,m);   %check whether 0 matrix is a solution
      if norm(f(X0))<tol, i=1; X(:,:,i)=X0; end
   end
   while (1) %infinite loop, press Ctrl+C to terminate or wait
      x0=ar+(br-ar)*rand(n,m);       %initial random matrix
      if ~isreal(A), x0=x0+(ai+(bi-ai)*rand(n,m))*1i; end  %complex
      try [x,~,key]=fsolve(f,x0,ff); catch, continue; end %discard it
      t=toc; if t>tlim, break; end   %no new solution found
      if key>0, N=size(X,3);         %find the number of solutions found
         for j=1:N, if norm(X(:,:,j)-x)<1e-4; key=0; break; end, end
         if key==0                   %if more precise solution is found
            if norm(f(x))<norm(f(X(:,:,j))), X(:,:,j)=x; end
         elseif key>0, X(:,:,i+1)=x; % record the new solution
            if norm(imag(x))>1e-8, i=i+1; X(:,:,i+1)=conj(x); %try conjugate
            end, assignin('base','X',X); i=i+1, tic  %更新信息
         end, assignin('base','X',X);
end, end, end
