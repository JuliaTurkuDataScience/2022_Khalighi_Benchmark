clear
clc

t0 = 0 ; T = 1; I0=0.1; y0=[1-I0;I0;0];
alpha=[.9,.9,.9];
h=0.1;
param.b=0.4; param.g=0.04;

F=@fun;
JF=@Jfun;

[tex,Exact]=fde_pi2_im(alpha,F,JF,t0,T,y0,2^(-4),param);
