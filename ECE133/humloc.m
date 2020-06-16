clc; clear;
epsilon=0.000001;% tolerance (small threshold) 
IterMAX = 5000; % maximal number of (main) iterations 
N = 10; 
lambda = 0.1; 
b1= 0.8; 
b2 = 2; 
last_norm = 1e10; 
t = (-pi + (2*pi).*rand(10,1))';
points = [0.5, 1.5; -0.3, 0.6; 1.0, 1.8; -0.4, 0.2; 0.2, 1.3; 0.7, 0.1; 2.3, 0.8; 1.4, 0.5; 0.0, 0.2; 2.4, 1.7]; 
y = [mean(points) 1 1 0.01 t]'; 

for i = 1:IterMAX 
    c1 = y(1,i); 
    c2 = y(2,i); 
    r = y(3,i); 
    delta = y(4,i); 
    alpha = y(5,i); 
    t = y(6:size(y,1),i); 
    for k = 1:N 
        u(1,k) = cos(alpha+t(k)); 
        v(1,k) = cos(alpha-t(k));
        p(1,k) = sin(alpha+t(k)); 
        q(1,k) = sin(alpha-t(k)); 
    end 
    %p = p'; 
    %q = q'; 
    %u = u'; 
    %v = v'; 
    f = [c1+r*u'+delta*v'; c2+r*p'+delta*q'] - [points(:,1); points(:,2)]; 
    df = [ones(N,1) zeros(N,1) u' v' -r*p'-delta*q' diag(-r*p'+delta*q'); zeros(N,1) ones(N,1) p' q' r*u'+delta*v' diag(r*u'-delta*v')];
    %p = p'; 
    %q = q'; 
    %u = u'; 
    %v = v'; 
    if norm(f) < last_norm 
        y(:,i+1) = y(:,i) - inv(df'*df+lambda(i)*eye(15))*df'* f; 
        lambda(:,i+1) = b1 * lambda(i); 
        last_norm = norm(f);
    else
        y(:,i+1) = y(:,i); 
        lambda(:,i+1) = b2 * lambda(i); 
    end
    if abs(norm(y(:,i))-norm(y(:,i+1))) < epsilon 
        break 
    end
end
n=size(y,2);
hold on 
plot(points(:,1),points(:,2),'o'); 
[X,Y] = ellipse(y(1,n), y(2,n), y(3,n), y(4,n), y(5,n)); plot(X, Y, '-')


function [x,y] = ellipse(c1,c2,r,delta,alpha)
   t = linspace(-pi,pi,400);
   x = c1+ r*cos(alpha + t) + delta*cos(alpha - t);
   y = c2+ r*sin(alpha + t) + delta*sin(alpha - t);
   
end
