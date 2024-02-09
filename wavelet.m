function [AA] = wavelet(A,n)
nbcol = size(colormap(gray),1);
cA = A;

for i=1:n
    [cA,cH,cV,cD] = dwt2(cA,'haar');
    % rescale to appropriate pseudocolor scaling
    cod_cH = wcodemat(cH,nbcol);
    cod_cV = wcodemat(cV,nbcol);
end

AA = cod_cH+cod_cV;
end

