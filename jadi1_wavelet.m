%perlu perbaikan di SVD agar nilai matriks ke 2 jadi 50->20 bukan 1.



cd dataset\train\resized
fname = ls;

N = length(fname);
for i=3:N
    data = imread(fname(i,:));
    data = double(rgb2gray(data));
    data = data(:,:,1); 
    Dmat_x(:,i-2) = reshape(data,size(data,1)*size(data,2),1);
end

% Training Set
cats = Dmat_x(:,1:50);
dogs = Dmat_x(:,51:100);

cd ..\..\
cd test\resized
fname = ls;

N = length(fname);
for i=3:N
    TestSet = imread(fname(i,:));
    TestSet = double(rgb2gray(TestSet));
    TestSet = TestSet(:,:,1); 
    Dmat_y(:,i-2) = reshape(TestSet,size(TestSet,1)*size(TestSet,2),1);
end
hiddenlabels = [1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0];


% Testing Set
probes = Dmat_y(:,:);

% Number of features
feature = 20;


cd ..\..\..
% Classify the probes as cats or dogs

nc = length(cats(1,:));
nd = length(dogs(1,:));
np = length(probes(1,:));

for i=1:nc
    cat0(:,:,i) = reshape(cats(:,i),64,64); % cats are of size 64x64
end
for i=1:nd
    dog0(:,:,i) = reshape(dogs(:,i),64,64); % dogs are of size 64x64
end
for i=1:np
    probe0(:,:,i) = reshape(probes(:,i),64,64); % probes are of size 64x64
end

% decomposition using wavelet
n = 1; % level of decomposition
for i=1:nc
    nbcol = size(colormap(gray),1);
    cA = cat0(:,:,i);

    for i=1:n
        [cA,cH,cV,cD] = dwt2(cA,'haar');
        % rescale to appropriate pseudocolor scaling
        cod_cH = wcodemat(cH,nbcol);
        cod_cV = wcodemat(cV,nbcol);
    end

    data = cod_cH+cod_cV;
    cat0_res(:,i) = reshape(data,size(data,1)*size(data,2),1);
end
for i=1:nd
    nbcol = size(colormap(gray),1);
    cA = dog0(:,:,i);

    for i=1:n
        [cA,cH,cV,cD] = dwt2(cA,'haar');
        % rescale to appropriate pseudocolor scaling
        cod_cH = wcodemat(cH,nbcol);
        cod_cV = wcodemat(cV,nbcol);
    end

    data = cod_cH+cod_cV;
    dog0_res(:,i) = reshape(data,size(data,1)*size(data,2),1);
end
for i=1:np
        nbcol = size(colormap(gray),1);
    cA = probe0(:,:,i);

    for i=1:n
        [cA,cH,cV,cD] = dwt2(cA,'haar');
        % rescale to appropriate pseudocolor scaling
        cod_cH = wcodemat(cH,nbcol);
        cod_cV = wcodemat(cV,nbcol);
    end

    data = cod_cH+cod_cV;
    probe0_res(:,i) = reshape(data,size(data,1)*size(data,2),1);
end

% 2-class classification
nc = length(cat0_res(1,:));
nd = length(dog0_res(1,:));

[U,S,V] = svd([cat0_res dog0_res],0);
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


test = U'*probe0_res;
pval = w'*test;
clsfy = zeros(1,np);
for i=1:np
    if pval(i)>threshold % dogs<threshold<cats
        clsfy(i) = 1; % classify as cats
    end
end

% counter = abs(clsfy - hiddenlabels);
true=0;

for i=1:20
    if(i>11)
        if(clsfy(i)==hiddenlabels(i))
            true=true+1;
        end
    else
        if(clsfy(i)==hiddenlabels(i))
            true=true+1;
        end
    end
end

percent = (true/20)*100;
