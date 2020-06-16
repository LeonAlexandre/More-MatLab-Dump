

%function modified from Julia companion book
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
    %use build in solver from Matlab
    z = lsqlin(Atill,btill,Ctill,dtill);
    %generate output    
    xslice = z(1:T*n); uslice = z(T*n+1:end);
    x = reshape(xslice, [4 100]);
    u = reshape(uslice, [2 99]);
    y(:,l) = x(:,l);
end