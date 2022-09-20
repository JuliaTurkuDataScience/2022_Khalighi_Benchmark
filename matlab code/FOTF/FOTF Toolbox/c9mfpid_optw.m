function y=c9mfpid_optw(x,ww,wcg,phi,ws,B,wt,A,k,tau,L)
jw=1i*ww; G=@(s)k*exp(-L*s)./(tau*s+1);
C=@(s)x(1)+x(2)./s.^x(4)+x(3)*s.^x(5); F=@(s)C(s).*G(s);
y=abs(angle(-(tau./(tau*jw+1)+L).*F(jw)-...
    G(jw).*(x(2)*x(4)./jw.^(x(4)+1)-x(3)*x(5)*jw.^(x(5)-1))));
y=sum(y);    
