clear
% Read in data
cd dataset\train\resized
fname = ls;

N = length(fname);
for i=1:N
    data = imread(fname(i,:));
    data = double(data);
    data = data(:,:,1); 
    Dmat_x(:,i-2) = reshape(data,size(data,1)*size(data,2),1);
end

% Training Set
cats = Dmat_x(:,1:50);
dogs = Dmat_X(:,51:100);

cd ..\..\
cd test\resized
fname = ls;

N = length(fname);
for i=3:N
    TestSet = imread(fname(i,:));
    TestSet = double(TestSet);
    TestSet = TestSet(:,:,1); 
    Dmat_y(:,i-2) = reshape(TestSet,size(TestSet,1)*size(TestSet,2),1);
end


% Testing Set
% load PatternRecAns
probes = Dmat_y(:,:);

% Number of features
feature = 20;

% Classify the probes as cats or dogs
clsfy = waveFDA(cats,dogs,probes,feature);
% counter = abs(clsfy - hiddenlabels);