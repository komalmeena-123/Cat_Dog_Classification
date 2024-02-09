function [clsfy] = maskFDA(cats,dogs,probes,energy)
nc = size(cats,2);
nd = size(dogs,2);
np = size(probes,2);

% Reshape the images back to 64*64
for i=1:nc
    cat(:,:,i) = reshape(cats(:,i),64,64);
end
for i=1:nd
    dog(:,:,i) = reshape(dogs(:,i),64,64);
end
for i=1:np
    probe(:,:,i) = reshape(probes(:,i),64,64);
end

% Apply the filter and the mask to extract the edges
for i=1:nc
data = mask(cat(:,:,i));
cats(:,i) = reshape(data,size(data,1)*size(data,2),1);
end
for i=1:nd
data = mask(dog(:,:,i));
dogs(:,i) = reshape(data,size(data,1)*size(data,2),1);
end
for i=1:np
data = mask(probe(:,:,i));
probes(:,i) = reshape(data,size(data,1)*size(data,2),1);
end

D = [cats dogs];
D = D - repmat(mean(D,2),[1,nc+nd]); % mean subtracted
[U S V] = svd(D,0);

% Find the best d value to use
Svec = diag(S);
totalenergy = dot(Svec,Svec);
currentenergy = 0;
for d = 1 : length(Svec)
    currentenergy = currentenergy + ((Svec(d))^2) / totalenergy;
    if currentenergy >= energy
        break
    end
end

% PCA
Ud = U(:,1:d);
qc = Ud'*cats;
qd = Ud'*dogs;
qp = Ud'*probes;

% Compute the optimal projection direction, w
A = S(1:d,1:d)*V(:,1:d)';
cat = A(:,1:nc);
dog = A(:,nc+1:nc+nd);
mc = mean(cat,2);
md = mean(dog,2);
SB = (md-mc)*(md-mc)';
M1 = repmat(mc,[1,nc]);
M2 = repmat(md,[1,nd]);
SW1 = (A(:,1:nc) - M1) * (A(:,1:nc) - M1)';
SW2 = (A(:,nc+1:nc+nd) - M2) * (A(:,nc+1:nc+nd) - M2)';
SW = SW1 + SW2;
[V2,d] = eig(SB,SW);
[l,ind] = max(abs(diag(d)));
w = V2(:,ind);
w = w/norm(w,2);

% Project the data and the probe onto a line
Cat = w'*qc;
Dog = w'*qd;
Probe = w'*qp;
if mean(Dog) > mean(Cat)
    w = -w;
    Dog = -Dog;
    Cat = -Cat;
    Probe = -Probe;
end

sortDog = sort(Dog);
sortCat = sort(Cat);
t1 = length(sortDog);
t2 = 1;

while sortDog(t1) > sortCat(t2)
    t1 = t1 - 1;
    t2 = t2 + 1;
end

threshold = (sortDog(t1)+sortCat(t2))/2;
clsfy = zeros(1,length(Probe));

for i = 1 : length(Probe)
    if Probe(i) > threshold
        clsfy(i) = 1;
    end
end
end

