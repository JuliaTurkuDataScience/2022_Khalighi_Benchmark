function [c,ceq]=c9mfpid_conw(x,ww,wcg,phi,ws,B,wt,A,k,tau,L)
jw=1i*wcg; G=@(s)k*exp(-L*s)/(tau*s+1);
C=@(s)x(1)+x(2)/s^x(4)+x(3)*s^x(5); F=@(s)C(s)*G(s);
ceq=[abs(F(jw))-1;
     angle(F(jw))+pi-phi*pi/180];
c=[20*log10(abs(1/(1+F(ws*1i))))-B;
   20*log10(abs(F(wt*1i)/(1+F(wt*1i))))-A];
