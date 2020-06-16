nmax = 6000;
x1 = Newtn(0.6,nmax)
x2 = Newtn(0,nmax)
x3 = Newtn2(0.5,nmax)
function x = Newtn(x,nmax)                                       
    err=1;                                                                                
    n=0;                                           
    while err>=1e-5&n<=nmax                       
        y = x -((10*x*exp(-2*x) + exp(-x) - 2)/ (10*exp(-2*x) -20*x*exp(-2*x) - exp(-x)));                           
        err=abs(y-x);                              
        x=y;n=n+1;                                  
    end    
end
function x = Newtn2(x,nmax)                                       
    err=1;                                                                                
    n=0;                                           
    while err>=1e-4&n<=nmax                       
        y = x - (10*exp(-2*x) -20*x*exp(-2*x) - exp(-x)) / (-40*exp(-2*x) +40*x*exp(-2*x) + exp(-x))  ;                      
        err=abs((10*exp(-2*x) -20*x*exp(-2*x) - exp(-x)))    ;              
        x=y;n=n+1;                                  
    end    
end
