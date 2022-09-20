function y=c9mfpid_opt2(x,wcg,phi,ws,B,wt,A,k,T,L,a)
s=1i*wcg; G=@(s)k*exp(-L*s)/(T*s^a+1); 
C=@(s)x(1)+x(2)/s^x(4)+x(3)*s^x(5); F=@(s)C(s)*G(s);
y=abs(angle(-(L*s+a*s^a*T+L*s^a+1)*T)/(s*(s^a*T+1)*F(s)-...
    G(s)*(x(2)*x(4)/s^(x(4)+1)-x(3)*x(5)*s^(x(5)-1))));
