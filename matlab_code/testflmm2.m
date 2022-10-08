clear
clc
a = 1 ; mu = 4 ;
fdefun = @(t,y) [ a-(mu+1)*y(1)+y(1)^2*y(2) ; mu*y(1)-y(1)^2*y(2) ] ;
Jfdefun = @(t,y) [ -(mu+1)+2*y(1)*y(2) , y(1)^2 ; mu-2*y(1)*y(2) , -y(1)^2 ] ;

alpha = 0.8 ;
t0 = 0 ; tfinal = 100 ; y0 = [ 0.2 ; 0.03] ;
h = 2^(-6) ;

[t, y_flmm2] = flmm2(alpha,fdefun,Jfdefun,t0,tfinal,y0,h) ;
