clear

% Read in data
cd TIFFtraining
fname = ls;
N = length(fname);
for i = 3:N
    data = imread(fname(i,:));
    data = double(data);
    data = data(:,:,1);
    Dmat(:,i-2) = reshape(data,size(data,1)*size(data,2),1);
end

cd ..

% Training Set
cats = Dmat(:,1:80);
dogs = Dmat(:,81:160);

% Testing Set
load PatternRecAns
probes = TestSet;

% Energy level for PCA
energy = 0.95;

% Classify the probes as cats or dogs
clsfy = maskFDA(cats,dogs,probes,energy);
counter = abs(clsfy - hiddenlabels);