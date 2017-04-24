%This program plots the poincare section of the pendulum when driving frequency f=4Hz 

%load data
clc
clear all
load force.mat
global alpha;
global F;
alpha=alpha0;
F=F0;
global d;
tspan=[0:0.01:800];

%i determines the releasing position of the pendulum, theta(0)=pi/30/2*i
i=25;
d=1;
[tt,xx]=ode45(@DxDtpre,tspan,[pi/30/2*i,0]); 
l=length(tt);

%Period=0.25s, sweep xx to get the diagram 
for i=1:1200
    plot(xx((40000+i*25),1),xx(40000+i*25,2),'*');
    hold on
end
