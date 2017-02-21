function [pFea, Nk,skew] = PreprocessAlgos( name,fea, k, reductToD,distance_P )
addpath(genpath(pwd));

if strcmp(name,'pca')==1
    [coff,score]= pca(fea);
    scoreNor=score;
    %scoreNor = NormalizeFea(score,0);
    pFea=scoreNor(:,1:end-reductToD);
elseif strcmp(name,'nothing')==1
	pFea=fea;
end
pFea=NormalizeFea(pFea,0);
%[nSize,nFea]=size(pFea);
[Nk] = GetDist_Sk(pFea,distance_P,k);
skew=skewness(Nk);
end
