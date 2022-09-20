function feq=c9mfpid(x,wcg,phi,ws,B,wt,A,k,T,L)
jw=1i*wcg; G=@(s)k*exp(-L*s)/(T*s+1);
C=@(s)x(1)+x(2)/s^x(4)+x(3)*s^x(5);
F=@(s)C(s)*G(s); feq(1)=abs(F(jw))-1;
feq(2)=angle(F(jw))+pi-phi*pi/180;
feq(3)=angle(-(T/(T*jw+1)+L)*F(jw)-...
    G(jw)*(x(2)*x(4)/jw^(x(4)+1)-x(3)*x(5)*jw^(x(5)-1)));
feq(4)=20*log10(abs(1/(1+F(ws*1i))))-B;
feq(5)=20*log10(abs(F(wt*1i)/(1+F(wt*1i))))-A;
