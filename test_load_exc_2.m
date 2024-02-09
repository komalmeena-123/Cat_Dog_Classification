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

% Energy level for PCA
energy = 0.95;

cd ..\..\..


% Classify the probes as cats or dogs
clsfy = maskFDA(cats,dogs,probes,energy);

true = 0;
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
