clear
clc

H=[2^(-3) 2^(-4) 2^(-5)  2^(-6)  2^(-7) 2^(-8)];
Bench=zeros(length(H),4,2);

F = @(t,y,al) 40320/gamma(9-al)*t.^(8-al) -3*gamma(5+al/2)/gamma(5-al/2)*t.^(4-al/2)+9/4*gamma(al+1) +(3/2*t.^(al/2)-t.^4).^3 - y.^(3/2) ;
JF = @(t,y,al) -3/2.*y.^(1/2) ;
alpha = 0.5 ;
param = alpha ;
t0 = 0 ; T = 1 ;
y0 = 0 ;

for i=1:length(H)
    h=H(i);

Bench(i,1,1) = timeit(@() fde_pi1_ex(alpha,F,t0,T,y0,h,param));
Bench(i,2,1) = timeit(@() fde_pi12_pc(alpha,F,t0,T,y0,h,param));
Bench(i,3,1) = timeit(@() fde_pi1_im(alpha,F,JF,t0,T,y0,h,param, 1e-8));
Bench(i,4,1) = timeit(@() fde_pi2_im(alpha,F,JF,t0,T,y0,h,param, 1e-8));

[t1,y1]=fde_pi1_ex(alpha,F,t0,T,y0,h,param);
[t2,y2]=fde_pi12_pc(alpha,F,t0,T,y0,h,param);
[t3,y3]=fde_pi1_im(alpha,F,JF,t0,T,y0,h,param, 1e-8);
[t4,y4]=fde_pi2_im(alpha,F,JF,t0,T,y0,h,param, 1e-8);

Exact=t1.^8 -3.*t1.^(4+alpha/2)+ 9/4*t1.^alpha;

Bench(i,1,2)=norm(y1-Exact);
Bench(i,2,2)=norm(y2-Exact);
Bench(i,3,2)=norm(y3-Exact);
Bench(i,4,2)=norm(y4-Exact);

end
%%
figure; 
sgtitle('Benchmark for nonStiff')
subplot(1,2,1)
loglog(H,Bench(:,:,1), 'LineWidth',3);
ylabel("Execution time (Sc)")
xlabel("step size")
legend("Explicit PI of rectanguar","Predictor-corrector PI rules","Implicit PI of rectanguar","Implicit PI trapezoidal rule")
subplot (1,2,2)
loglog(H,Bench(:,:,2),'LineWidth',3);
ylabel("Square norm of errors")
xlabel("step size")

figure
loglog(Bench(:,:,1),Bench(:,:,2), 'LineWidth',3);
xlabel("Execution time (Sc)")
ylabel("Square norm of errors")
legend("Explicit PI of rectanguar","Predictor-corrector PI rules","Implicit PI of rectanguar","Implicit PI trapezoidal rule")
%%
csvwrite('BenchNonStiff.csv',Bench)