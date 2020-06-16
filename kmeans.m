%Alexandre Leon 504941684
load wikipedia_m.mat;
k = 8;
[assign,reps, distances, Jnow] = kMeanAlgo(tdmatrix,k);
list = [distances, articles];
topar = strings(5,k);
for i =1:k
   I = find( assign == i);
   subI = sortrows(list(I,:),1);
   topar(:,i) = subI(1:5, 2);

end

[B,C] = maxk(reps, 5, 1);
topwor = dictionary(C);
disp(Jnow)

function [assignments, reps, distances, Jnow] =  kMeanAlgo(x,k)
maxiter = 100;
tolerance = 1E-9;
N = size(x,2); %number of points = 500
n = size(x,1); %dimension = 4423
distances = zeros(N,1); %dist to closest rep
reps = zeros(n,k); %storing reps
assignments = randi(k, 1, 500); %random initial assignment
JPrev = Inf;
for iter = 1:maxiter
    %For points in cluster j, 
    %find average position of points
    %set as represntative
    for j = 1:k
        I = find(assignments == j); %finds all in group
        subI = x(:,I) ; %isolates the entries
        reps(:,j) = sum(subI,2) / size(subI,2);   
    end
    %now for each, find distance to closest representative   
    for i = 1:N
        norms = zeros(k,1);
        for j = 1:k
            norms(j) = norm( x(:,i) - reps(:, j), 1);
        end      
            [distances(i),assignments(i)] = min(norms);    
    end
    Jnow = norm(distances)^2 / N;    
    disp(["Iteration ", num2str(iter), ": Jnow = ", num2str(Jnow), "JPrev=", num2str(JPrev)]);
    if( (iter > 1) && (abs(Jnow - JPrev) < tolerance))
        return
    end
    JPrev = Jnow; 
end
end

