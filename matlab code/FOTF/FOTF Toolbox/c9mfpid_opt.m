function y=c9mfpid_opt(x,wcg,phi,ws,B,wt,A,k,T,L)
jw=1i*wcg; G=@(s)k*exp(-L*s)/(T*s+1);
C=@(s)x(1)+x(2)/s^x(4)+x(3)*s^x(5); F=@(s)C(s)*G(s);
y=abs(angle(-(T/(T*jw+L)+L)*F(jw)-...
    G(jw)*(x(2)*x(4)/jw^(x(4)+1)-x(3)*x(5)*jw^(x(5)-1))));
