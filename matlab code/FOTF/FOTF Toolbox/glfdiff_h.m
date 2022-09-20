function dy=glfdiff_h(y,t,gam,nd)
   h=t(2)-t(1);  y=y(:); t=t(:); a0=y(1); dy(1)=0; n=length(t);
%   if a0~=0 & gam>0, dy(1)=sign(a0)*Inf; end
   switch nd
       case 1
           w=1; for k=2:n, w(k)=w(k-1)*(1-(gam+1)/(k-1)); end
       case 2
           w0=(3/2)^gam; w1=-4*gam*w0/3; w=[w0, w1];
           for k=3:n, w(k)=(4*(k-2-gam)*w(k-1)+(-k+3+2*gam)*w(k-2))/3/(k-1); end
       case 3
           w0=(11/6)^gam; w1=-18*gam*w0/11; w2=9*gam*w0/11+9*(1-gam)*w1/11;
           w=[w0,w1,w2];
           for k=4:n, w(k)=(18*(k-2-gam)*w(k-1)-9*(k-3-2*gam)*w(k-2)+2*(k-4-3*gam)*w(k-3))/11/(k-1); end
       case 4
           w0=(25/12)^gam; w1=-gam*48*w0/25; w2=(24*(1-gam)*w1+36*gam*w0)/25; 
           w3=(-gam*w0*16+(2*gam-1)*w1*12+(2-gam)*w2*16)/25;
           w=[w0,w1,w2,w3];
           for k=5:n, w(k)=(48*(k-2-gam)*w(k-1)+36*(2*gam-k+3)*w(k-2)+16*(k-4-3*gam)*w(k-3)+3*(4*gam-k+5)*w(k-4))/25/(k-1); end
       case 5
           w0=(137/60)^gam; w1=-gam*300/137*w0; w2=(150*(1-gam)*w1+300*gam*w0)/137; 
           w3=(-200*gam*w0+100*(2*gam-1)*w1+100*(2-gam)*w2)/137;
           w4=(75*(3-gam)*w3+150*(gam-1)*w2+50*(1-3*gam)*w1+75*gam*w0)/137;
           w=[w0,w1,w2,w3,w4];
           for k=6:n, w(k)=(300*(k-2-gam)*w(k-1)+300*(2*gam-k+3)*w(k-2)+200*(k-4-3*gam)*w(k-3)+75*(4*gam-k+5)*w(k-4)+12*(k-6-5*gam)*w(k-5))/137/(k-1); end
       case 6
           w0=(147/60)^gam; w1=-gam*360/147*w0; w2=(180*(1-gam)*w1+450*gam*w0)/147; 
           w3=(-400*gam*w0+150*(2*gam-1)*w1+120*(2-gam)*w2)/147;
           w4=(90*(3-gam)*w3+225*(gam-1)*w2+100*(1-3*gam)*w1+225*gam*w0)/147;
           w5=(72*(4-gam)*w4+90*(2*gam-3)*w3+80*(2-3*gam)*w2+45*(4*gam-1)*w1-72*gam*w0)/147;
           w=[w0,w1,w2,w3,w4,w5];
           for k=7:n, w(k)=(360*(k-2-gam)*w(k-1)+450*(2*gam-k+3)*w(k-2)+400*(k-4-3*gam)*w(k-3)+225*(4*gam-k+5)*w(k-4)+72*(k-6-5*gam)*w(k-5)-10*(k-7-6*gam)*w(k-6))/147/(k-1); end
       otherwise
           disp('order is too high')
   end
%   for i=nd+1:n, w(i)=aa*w(i-1:-1:i-nd); end
   for i=2:n, dy(i)=w(1:i)*[y(i:-1:1)]/h^gam; end
