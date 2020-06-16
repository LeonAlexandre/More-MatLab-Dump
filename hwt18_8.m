clear all;hold off; grid on
xdata = [0.5 -0.3 1.0 -0.4 0.2 0.7 2.3 1.4 0.0 2.4]';
ydata = [1.5 0.6 1.8 0.2 1.3 0.1 0.8 0.5 0.2 1.7]';
points = horzcat(xdata,ydata);
c1 = mean(xdata); c2 = mean(ydata);
tol = 1e-6;
scatter(xdata,ydata)
t = [0.994 1.69 0.669 1.83 1.25 2.30 -0.0223 -0.269 1.92 0.237];
y_initial = [mean(points) 1 1 0.01 t]';
lambda_initial = 1; nmax = 50000;
[y,lambda] = fitEllipse(y_initial, lambda_initial,points, tol,nmax);
n=size(y,2); 
[X,Y] = buildEllipse(y(1,n), y(2,n), y(3,n), y(4,n), y(5,n)); 
plot(X, Y, points(:,1),points(:,2),'o');
%%

function [x,y] = buildEllipse(c1,c2,r,delta,alpha)
   t = linspace(-pi,pi,400);
   x = c1+ r*cos(alpha + t) + delta*cos(alpha - t);
   y = c2+ r*sin(alpha + t) + delta*sin(alpha - t);
end
function [y,lambda] = fitEllipse(y_initial, lambda,points, tol, nmax)
    last_norm = 1e10;y = y_initial;N = 10;b1= 0.8;  b2 = 2;
    for i = 1:nmax
        c1 = y(1,i);  c2 = y(2,i); r = y(3,i); delta = y(4,i); alpha = y(5,i); t = y(6:size(y,1),i); 
        for k = 1:N 
            u(1,k) = cos(alpha+t(k)); 
            v(1,k) = cos(alpha-t(k));
            p(1,k) = sin(alpha+t(k)); 
            q(1,k) = sin(alpha-t(k)); 
        end 
        f = [c1+r*u'+delta*v'; c2+r*p'+delta*q'] - [points(:,1); points(:,2)]; 
        df = [ones(N,1) zeros(N,1) u' v' -r*p'-delta*q' diag(-r*p'+delta*q'); zeros(N,1) ones(N,1) p' q' r*u'+delta*v' diag(r*u'-delta*v')];
        if norm(f) < last_norm 
            y(:,i+1) = y(:,i) - inv(df'*df+lambda(i)*eye(15))*df'* f; 
            lambda(:,i+1) = b1 * lambda(i); 
            last_norm = norm(f);
        else
            y(:,i+1) = y(:,i); 
            lambda(:,i+1) = b2 * lambda(i); 
        end
        if abs(norm(y(:,i))-norm(y(:,i+1))) < tol 
            break 
        end
    end
end