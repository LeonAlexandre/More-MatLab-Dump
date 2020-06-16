G = graph([1 1 1 2 2 2 2 3 3 4 5 6 6],[3 4 7 3 5 8 9 4 5 6 6 9 10]);
h = plot(G);grid on; %brings up the graph
I = full(incidence(G));Ip = I';
C = Ip(:,1:6); D = Ip(:,7:end);
s = size(C); e = size(D); A = [C zeros(s); zeros(s) C];
uv = [0 0 1 1 0 1 1 0]';  b = -[D zeros(e); zeros(e) D]*uv;
x =  (A \ b); 
varNames= {'Points','X','Y'};T =table([1:10]', u', v','VariableNames',varNames)
u = horzcat(x(1:6)',uv(1:4)'); h.XData = u;
v = horzcat(x(7:12)',uv(5:end)'); h.YData = v;