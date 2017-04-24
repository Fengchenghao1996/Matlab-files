%this function is of most importantance in the magnet pendulum
%solve dynamic equation of the pendulum

function xdot=DxDtpre(t,x)

%the global variables are determined by Main m files
global alpha;
global F;
global d;

%{
w:the angular frequency of driving force
w0:natrual angular frequency of driving force
mu:damping coefficient.
c: a variable to change the magnitude of driving force
%}
w0=0.8115*2*pi;
mu=0.16;w=w0*7;c=d;
x1=x(1);

%x1>0.45, the driving force can be approximated to 0
if (x1<=0.45)&&(x1>=-0.45)
f=interp1(alpha,F,x1,'spline');
xdot=[x(2);-mu*x(2)-w0^2*sin(x(1))+c*f*210*cos(w*t)];
else
 xdot=[x(2);-mu*x(2)-w0^2*sin(x(1))];
end
end

 
