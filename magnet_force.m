%This program calculate the magnet driving force driven by a elctric magnet
%The first program to run in the series of magnet pendulum
clear all;

%{
The description of the electric magnet
Mu0:magnetic permeability
I0:Driving current
x0,y0:the area to calculate magnet field
z0:the coordinate of the pendulm that placed vertically
h:the length of the pendulum
d:the distance betwwen two neighboring coils
%}
Mu0=4*pi*1e-7;
I0=1;Rh=0.042;
C0=Mu0/(4*pi);
x0=0.2;y0=0.2;z0=0.04;h=0.456;
Nx=100;Ny=100;Nz=100;
x=linspace(-x0,x0,Nx);
y=linspace(-y0,y0,Ny);
z=-sqrt(h.^2-x.^2)+h+0.014;
d=0.00082;

%initialization
Bx=zeros(Nx,Nz);
Bz=zeros(Nx,Nz);

%use Biot Savart law to calculate magnet field
for j=1:Nx
   for k=1:Nz
      for m=1:110
         z0=z(k)+d*m;
         fx=@(theta)(2*Rh*C0*z0*cos(theta))/((x(j)*x(j)+(Rh*Rh+z0*z0)-2*(x(j)*Rh)*cos(theta)).^(3/2));
         Bx(j,k)=integral(fx,0,pi,'ArrayValued',true)+ Bx(j,k);
         fz=@(theta)(2*C0)*(Rh.^2-x(j)*(Rh*cos(theta)))/((x(j)*x(j)+(Rh*Rh+z0*z0)-2*(x(j)*Rh)*cos(theta)).^(3/2));
         Bz(j,k)=integral(fz,0,pi,'ArrayValued',true)+ Bz(j,k);
      end
   end
end

%get the gradient of the magnet field
[Bxx,Bxz]=gradient(Bx);
[Bzx,Bzz]=gradient(Bz);
%transform coordinate 
alpha=asin(x./h);

%use magnet dipole model to calculate the driving force the pendulum experienced
for n=1:100
 F(n)=(cos(alpha(n)*1)*(Bxx(n,n)+Bxz(n,n)))+(sin(alpha(n))*(Bzx(n,n)+Bzz(n,n)));
end
%save F, alpha and get the force.mat



