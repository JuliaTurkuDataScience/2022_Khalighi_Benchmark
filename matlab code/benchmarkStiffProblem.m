clear
clc

H=2.^(-3:-1:-8);
Bench=zeros(length(H),2,2);

alpha = 0.8; lambda = -10 ;
F = @(t,y,lam) lam * y;
JF = @(t,y,lam) lam ;
param = lambda ;
t0 = 0 ; T = 5 ; y0 = 1 ;

[tex,Exact]=fde_pi2_im(alpha,F,JF,t0,T,y0,2^(-10),param, 1e-12);
I=1;
for i=3:8
    h=2^(-i);

Bench(I,1,1) = timeit(@() fde_pi1_ex(alpha,F,t0,T,y0,h,param));
Bench(I,2,1) = timeit(@() fde_pi12_pc(alpha,F,t0,T,y0,h,param,4));
Bench(I,3,1) = timeit(@() fde_pi1_im(alpha,F,JF,t0,T,y0,h,param, 1e-8));
Bench(I,4,1) = timeit(@() fde_pi2_im(alpha,F,JF,t0,T,y0,h,param,1e-8));

[t1,y1]=fde_pi1_ex(alpha,F,t0,T,y0,h,param);
[t2,y2]=fde_pi12_pc(alpha,F,t0,T,y0,h,param,4);
[t3,y3]=fde_pi1_im(alpha,F,JF,t0,T,y0,h,param,1e-8);
[t4,y4]=fde_pi2_im(alpha,F,JF,t0,T,y0,h,param,1e-8);

Bench(I,1,2)=norm(y1-Exact(:,1:2^(10-i):end));
Bench(I,2,2)=norm(y2-Exact(:,1:2^(10-i):end));
Bench(I,3,2)=norm(y3-Exact(:,1:2^(10-i):end));
Bench(I,4,2)=norm(y4-Exact(:,1:2^(10-i):end));
I=I+1;
end
%% plot
figure; 
sgtitle('Benchmark for Stiff')
subplot(1,2,1)
loglog(H,Bench(:,:,1), 'LineWidth',3);
ylabel("Execution time (Sc)")
xlabel("step size")
% legend("Explicit PI of rectanguar","Predictor-corrector PI rules","Implicit PI of rectanguar","Implicit PI trapezoidal rule")
subplot (1,2,2)
loglog(H,Bench(:,:,2),'LineWidth',3);
ylabel("Square norm of errors")
xlabel("step size")

figure
loglog(Bench(:,:,1),Bench(:,:,2), 'LineWidth',3);
xlabel("Execution time (Sc)")
ylabel("Square norm of errors")
% legend("Explicit PI of rectanguar","Predictor-corrector PI rules","Implicit PI of rectanguar","Implicit PI trapezoidal rule")
%%
csvwrite('BenchStiff.csv',Bench)