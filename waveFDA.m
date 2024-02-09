function [clsfy,sortdog,sortcat, pval] = waveFDA(cats,dogs,probes,feature)
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
    data= wavelet(cat0(:,:,i),n);
    cat0_res(:,i) = reshape(data,size(data,1)*size(data,2),1);
end
for i=1:nd
    data = wavelet(dog0(:,:,i),n);
    dog0_res(:,i) = reshape(data,size(data,1)*size(data,2),1);
end
for i=1:np
    data = wavelet(probe0(:,:,i),n);
    probe0_res(:,i) = reshape(data,size(data,1)*size(data,2),1);
end

% 2-class classification
[U,vcat,vdog,threshold,w,sortdog,sortcat] = FDA(cat0_res,dog0_res,feature);
test = U'*probe0_res;
pval = w'*test;
clsfy = zeros(1,np);
for i=1:np
    if pval(i)>threshold % dogs<threshold<cats
        clsfy(i) = 1; % classify as cats
    end
end
end

