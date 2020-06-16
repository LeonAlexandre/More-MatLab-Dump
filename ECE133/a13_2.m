%%
%A13.2 Alexandre Leon
clear;
[u, v] = robappr; n = length(u);

A = horzcat(ones(n,1),u); y = v;
x = A \ v
al = x(1); be = x(2);
hold off; hold on;
scatter(u,v);
plot(u, al + be .*u); grid on;
A = horzcat(ones(n,1),u); y = v;
x = A \ y;
x_init = x; nmax = 10000; tol = 1e-6;
[x2,n] = Newtn(x_init,A, y, x,nmax, tol)
plot(u, x2(1) + x2(1) .*u); grid on; legend('Part a','Part b');
function [x,n] = Newtn(x_init,A, y, x,nmax, tol)                                       
    err=1;                                                                                
    n=0;
    x = x_init;
    c = 25;  
    
    while err>=tol && n<=nmax   
        %evaluate grad and hess
        z = A*x - y;
        grad = A'*(z./((z.^2 + c).^(1/2)));
        hess = A'*diag((c ./((z.^2 + c).^(3/2))))*A;        
        err = norm(grad);   
        %solve hess v = -grad
        v = - inv(hess)*grad;
        x = x + v;   
        n = n+1;        
    end    
end


