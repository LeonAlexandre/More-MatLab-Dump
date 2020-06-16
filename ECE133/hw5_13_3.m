mooreslaw
x = T(:,1); y = log10(T(:,2)); l = length(x);
A = horzcat(ones(l,1),(x - 1970));
th = A \ y;
Npredict = th(1) + (2015-1970)*th(2)
err = (10^Npredict - 4e9)/4e9 *100

%we code Moore's Law as a low an high estimate
t = [1971:2:2003];l = [1:2003-1971];
m = log10(2250.*2.^l); m= imresize(m,[1,length(t)],'nearest');
plot(x,th(1) + (x - 1970).*th(2),x,y,t,m);
legend('Approximation','Real values','Moore Lower bound');

