%hw7_17.6 Alexandre Leon 504941684

A = [ 0.99 0.03 -0.02 -0.32; 
    0.01 0.47 4.70 0.00;
    0.02 -0.06 0.40 0.00;
    0.01 -0.04 0.72 0.99];
B = [0.01 0.99;
    -3.44 1.66;
    -0.83 0.44;
    -0.47 0.25];
%part a
%Open loop trajectory
T = 120;
xinit = [0;0;0;1];
x = horzcat(xinit,zeros(4,T-1)); %initialize
for i =2:T
   x(:,i) = A*x(:,i-1);
end
hold off; hold on; grid on;
subplot(2,2,1);
plot(1:T,x(1,:));title('Velocity along axis');xlabel('t');
subplot(2,2,2);
plot(1:T,x(2,:));title('Velocity perpendicular to axis');xlabel('t');
subplot(2,2,3);
plot(1:T,x(3,:));title('Angle of body axis');xlabel('t');
subplot(2,2,4);
plot(1:T,x(4,:));title('Pitch rate');xlabel('t');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0  1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 0.98,'Part a');
%%
%part b 
%Linear quadratic control
C = eye(4);
rho = 100;
x_init = [0; 0; 0; 1];
x_des = [0; 0; 0; 0];
T = 100;
[x,u,y] =  jalapeno(A,B,C,x_init,x_des,T,rho);
xextra = zeros(4,20); uextra = zeros(2,20); x = horzcat(x,xextra); u = horzcat(u,uextra); T = 120;
subplot(3,2,1);
plot(1:T,x(1,:));title('Velocity along axis x1');xlabel('t');
subplot(3,2,2);
plot(1:T,x(2,:));title('Velocity perpendicular to axis x2');xlabel('t');
subplot(3,2,5);
plot(1:T-1,u(1,:));title('Elevator angle u1');xlabel('t');
subplot(3,2,3);
plot(1:T,x(3,:));title('Angle of body axis x3');xlabel('t');
subplot(3,2,4);
plot(1:T,x(4,:));title('Pitch rate x4');xlabel('t');
subplot(3,2,6);
plot(1:T-1,u(2,:));title('Engine thrust u2');xlabel('t');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0  1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 0.98,'Part b');


%%
%part 3
% we find the K matrix by solving with x_init = I4, x_des = 0
rho = 100;
I = eye(4);
T = 100;
x_des = [0; 0; 0; 0];
x_init = I(:,1);[xsf1,usf1,ysf1] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,2);[xsf2,usf2,ysf2] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,3);[xsf3,usf3,ysf3] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,4);[xsf4,usf4,ysf4] =  jalapeno(A,B,C,x_init,x_des,T,rho);
K_100 = horzcat( usf1(:,1),usf2(:,1),usf3(:,1),usf4(:,1))
%now with T = 50;
T = 50;
x_des = [0; 0; 0; 0];
x_init = I(:,1);[xsf1,usf1,ysf1] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,2);[xsf2,usf2,ysf2] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,3);[xsf3,usf3,ysf3] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,4);[xsf4,usf4,ysf4] =  jalapeno(A,B,C,x_init,x_des,T,rho);

K_50 = horzcat( usf1(:,1),usf2(:,1),usf3(:,1),usf4(:,1))

%We observe that the K matrix does not change much for T=100 and T = 50



%%
%Part d
rho = 100;
I = eye(4);
T = 120;
x_des = [0; 0; 0; 0];
x_init = I(:,1);[xsf1,usf1,ysf1] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,2);[xsf2,usf2,ysf2] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,3);[xsf3,usf3,ysf3] =  jalapeno(A,B,C,x_init,x_des,T,rho);
x_init = I(:,4);[xsf4,usf4,ysf4] =  jalapeno(A,B,C,x_init,x_des,T,rho);
K_120 = horzcat( usf1(:,1),usf2(:,1),usf3(:,1),usf4(:,1))
x = [x_init zeros(4,T - 1)];
for k = 1:T-1 %iterative method
   x(:,k+1) = (A + B*K_120)*x(:,k); 
end
u = K_120*x(:, 1:end-1);
y = C*x;
subplot(3,2,1);
plot(1:T,x(1,:));title('Velocity along axis x1');xlabel('t');
subplot(3,2,2);
plot(1:T,x(2,:));title('Velocity perpendicular to axis x2');xlabel('t');
subplot(3,2,5);
plot(1:T-1,u(1,:));title('Elevator angle u1');xlabel('t');
subplot(3,2,3);
plot(1:T,x(3,:));title('Angle of body axis x3');xlabel('t');
subplot(3,2,4);
plot(1:T,x(4,:));title('Pitch rate x4');xlabel('t');
subplot(3,2,6);
plot(1:T-1,u(2,:));title('Engine thrust u2');xlabel('t');
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0  1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 0.98,'Part d'); snapnow;

%%
%function modified from Julia companion book
dff = 0;
function [x,u,y] =  jalapeno(A,B,C,x_init,x_des,T,rho)
    n = size(A,1);
    m = size(B,2);
    p = size(C,1);
    q = size(x_init,2);
    Atill = [ kron(eye(T), C) zeros(p*T,m*(T-1)) ;
    zeros(m*(T-1), n*T) sqrt(rho)*eye(m*(T-1)) ];
    btill = zeros(p*T + m*(T-1), q);
    Ctil11 = [ kron(eye(T-1), A) zeros(n*(T-1),n) ] - [ zeros(n*(T-1), n) eye(n*(T-1)) ];
    Ctil12 = kron(eye(T-1), B);
    Ctil21 = [eye(n) zeros(n,n*(T-1)); zeros(n,n*(T-1)) eye(n)];
    Ctil22 = zeros(2*n,m*(T-1));
    Ctill = [Ctil11 Ctil12; Ctil21 Ctil22];
    dtill = [zeros(n*(T-1), q); x_init; x_des];
    options = optimoptions('lsqlin','Display','none');
    %use build in solver from Matlab
    z = lsqlin(Atill,btill,Ctill,dtill,[],[],[],[],[], options);
    %generate output    
    xslice = z(1:T*n); uslice = z(T*n+1:end);
    x = reshape(xslice, [n T]);
    u = reshape(uslice, [m T-1]);
    y = x;
end
