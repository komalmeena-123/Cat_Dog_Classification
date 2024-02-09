function [AA] = mask(A)

% The weighted average filter
filter = (1/16)*[1 2 1 ; 2 4 2 ; 1 2 1];

% The Laplacian mask
mask = [-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];

Af = conv2(A,filter,'same');
Afm = conv2(Af,mask,'same');

nbcol = size(colormap(gray),1);

AA = wcodemat(Afm,nbcol);
end

