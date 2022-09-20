function y=bp7_opts(x)
   W=get_param(gcs,'ModelWorkspace'); assignin(W,'a',x(1))
   try, txy=sim('bp7_model'); y0=txy.yout; y=abs(y0(end)-exp(-1));
   catch, y=10; end
end
