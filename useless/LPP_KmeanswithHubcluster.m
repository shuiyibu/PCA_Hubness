function [res ] = LPP_KmeanswithHubcluster( feature,fea,k,K ,label,loadDataName,isSave,times)
%LPP_KMEANSWITHHUBCLUSTER Summary of this function goes here
%   Detailed explanation goes here
addpath(genpath(pwd));
[nSam,nFea]=size(fea);

%%%Construct Adjoint matrix
options = [];
% options.Metric = 'Euclidean';
options.NeighborMode = 'KNN';
options.k = k;
options.WeightMode = 'HeatKernel';
options.t = 5;
[W,k_ocurrence] = constructW(fea,options);
skewness1=skewness(k_ocurrence);


[sk_ocurrence,idx]=sort(k_ocurrence,'descend');


%LPP
options.PCARatio = 0.99
[eigvector, eigvalue] = LPP(W, options, fea);
Y = fea*eigvector;
[W2,k_ocurrence2] = constructW(Y,options);
skewness2=skewness(k_ocurrence2);

iterSilh=[];
start=[];
for i=1:K
    start(i,:)=Y(idx(i),:);
end
% disp('kmeans');
[silh1,iterSilh1,times1 ]=Evaluate(fea,feature,times,K,k_ocurrence,'non','kmeans');
% disp('kmeans with LPP');
[silh2,iterSilh2,times2]=Evaluate(Y,feature,times,K,k_ocurrence,'non','LPPKmeans');


% disp('based-hub kmeans with LPP');
[silh3,iterSilh3,times3]=Evaluate(Y,feature,times,K,k_ocurrence,start ,'LHKmeans');

if isSave==1
    iterSilh=[iterSilh1;iterSilh2;iterSilh3];
end
%save result
res=[];
res.k=k;
res.skewness=[skewness1,skewness2];
res.nFea=[nFea,size(Y,2)];
res.iterSilh=iterSilh;
res.silh=[silh1,silh2,silh3];
res.times=[times1,times2,times3];
% Y=[Y label];
% %save dimension reduction data
% saveDataPath='/Users/langdylan/Downloads/';
% saveDataName=strcat(loadDataName,'_LPP','.csv');
% saveData(saveDataPath,saveDataName,Y);


end

