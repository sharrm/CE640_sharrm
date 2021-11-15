function trajectory=traj(t,x,par);

angle = par(1);
drag = par(2);
gravity = par(3);

trajectory=[x(3); x(4); -drag*sqrt(x(3)^2+x(4)^2)*x(3); -drag*sqrt(x(3)^2+x(4)^2)*x(4)-gravity];


