function [U,vcat,vdog,threshold,w,sortdog ,sortcat] = FDA(cat0,dog0,feature)
nc = length(cat0(1,:));
nd = length(dog0(1,:));

[U,S,V] = svd([cat0 dog0],0);
coeff = S*V';
U = U(:,1:feature);

cats = coeff(1:feature,1:nc);
dogs = coeff(1:feature,nc+1:nc+nd);

mc = mean(cats,2);
md = mean(dogs,2);
SW = 0; % within class variances

for i=1:nc
    SW = SW + (cats(:,i)-mc)*(cats(:,i)-mc)'; %~\ref{Fi:Mask cat dog}s
end
for i=1:nd
    SW = SW + (dogs(:,i)-md)*(dogs(:,i)-md)';
end

SB = (md-mc)*(md-mc)'; % between class variances
[V2,D] = eig(SB,SW);
[lambda,ind] = max(abs(diag(D)));

w = V2(:,ind);
w = w/norm(w,2);

vdog = w'*dogs;
vcat = w'*cats;

if mean(vdog)>mean(vcat)
    w = -w;
    vdog = -vdog;
    vcat = -vcat;
end

sortdog = sort(vdog);
sortcat = sort(vcat);
%very simple. They are only
t1 = length(sortdog);
t2 = 1;
while sortdog(t1)>sortcat(t2)
    t1 = t1-1;
    t2 = t2+1;
end

threshold = (sortdog(t1)+sortcat(t2))/2;
end

