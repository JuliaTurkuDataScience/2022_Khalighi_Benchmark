function fy=fun_opts(x)
   global G t key1 key2; 
   t0=t(1); t1=t(end); N=length(t);
   dt=t(2)-t(1); Gf=get_fpidf(x,G,key1); U='1/s';
   [t,y]=INVLAP_new(Gf,t0,t1,N,1,U); e=1-y;
   switch key2
       case {'itae','ITAE',1}, fy=dt*sum(t.*abs(e));
       case {'ise','ISE',2}, fy=dt*sum(e.^2);
       case {'iae','IAE',3}, fy=dt*sum(abs(e));
   end
   disp([x(:).' fy])
end
