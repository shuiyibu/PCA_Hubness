
loadDataPath='/Users/langdylan/MasterArticle/Code/dataset/Wpbc/Wpbc.xlsx';
X=xlsread(loadDataPath);
k=16;
feature=X(:,1:end-1);
feaNor = NormalizeFea(feature,0);

%%%Construct Adjoint matrix
options = [];
% options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 5;

[nSam,nFea]=size(feature);

for i=1:nFea/4
    fea=feaNor(:,1:end-i+1);
    [W,k_ocurrence] = constructW(fea,options);
    skewness1=skewness(k_ocurrence);
    disp(skewness1);
end
disp('-------------------------------------')

[coff,score]= pca(feature);
scoreNor = NormalizeFea(score,0);
for i=1:nFea/4
    fea=scoreNor(:,1:end-i+1);
    [W,k_ocurrence] = constructW(fea,options);
    skewness1=skewness(k_ocurrence);
    disp(skewness1);
end
