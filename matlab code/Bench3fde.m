%% bench 
    
clear
clc

H=[2^(-3) 2^(-4) 2^(-5) 2^(-6) 2^(-7)];

Bench=zeros(length(H),4,2);

alpha = [0.5, 0.2, 0.6] ;
F = @(t,y) [(((y(2)-0.5).*(y(3)-0.3)).^(1/6) + sqrt(t))/sqrt(pi) ; ...
gamma(2.2)*(y(1)-1) ; ...
gamma(2.8)/gamma(2.2)*(y(2)-0.5) ] ;
JF = @(t,y) [0 , (y(2)-0.5).^(-5/6).*(y(3)-0.3).^(1/6)/(6*sqrt(pi)) , ...
(y(2)-0.5).^(1/6).*(y(3)-0.3).^(-5/6)/(6*sqrt(pi)) ; ...
gamma(2.2) , 0 , 0 ; 0 , gamma(2.8)/gamma(2.2) , 0 ] ;
t0 = 0 ; T = 5 ;
y0 = [ 1 ; 0.500000001 ; 0.300000001 ] ;

for i=1:length(H)
    h=H(i);

Bench(i,1,1) = timeit(@() fde_pi1_ex(alpha,F,t0,T,y0,h));
Bench(i,2,1) = timeit(@() fde_pi12_pc(alpha,F,t0,T,y0,h));
Bench(i,3,1) = timeit(@() fde_pi1_im(alpha,F,JF,t0,T,y0,h,[],1e-8));
Bench(i,4,1) = timeit(@() fde_pi2_im(alpha,F,JF,t0,T,y0,h,[],1e-8));

[t1,y1]=fde_pi1_ex(alpha,F,t0,T,y0,h);
[t2,y2]=fde_pi12_pc(alpha,F,t0,T,y0,h);
[t3,y3]=fde_pi1_im(alpha,F,JF,t0,T,y0,h,[],1e-8);
[t4,y4]=fde_pi2_im(alpha,F,JF,t0,T,y0,h,[],1e-8);

Exact=[t1+1; t1.^(1.2)+0.5; t1.^(1.8)+0.3];

Bench(i,1,2)=norm(y1-Exact);
Bench(i,2,2)=norm(y2-Exact);
Bench(i,3,2)=norm(y3-Exact);
Bench(i,4,2)=norm(y4-Exact);

end

%% plot
figure; 
sgtitle('Benchmark for SIR')
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
ylabel("Execution time (Sc)")
ylabel("Square norm of errors")
% legend("Explicit PI of rectanguar","Predictor-corrector PI rules","Implicit PI of rectanguar","Implicit PI trapezoidal rule")
%% save the data
csvwrite('Bench3fde.csv',Bench)