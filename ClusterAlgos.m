function [avgSilh,iterSilh] = ClusterAlgos(cluName,pFea,numOfCls,times,k_ocurrence,feature,distance)
addpath(genpath(pwd));

%Compute init cluster centers
[sk_ocurrence,idx]=sort(k_ocurrence,'descend');
start=[];
for i=1:numOfCls
    start(i,:)=pFea(idx(i),:);
end

%Set repetition number
rep=5;

[nSam,nFea]=size(pFea);
iterSilh=zeros(1,times);
sumSilh=0;
%start cluster...
for i=1:times
    if strcmp(cluName,'kmeans')==1
        [IDX,C] =kmeans(pFea,numOfCls, 'rep',rep);
    elseif strcmp(cluName,'LPPKmeans')==1
        [IDX,C] =kmeans(pFea,numOfCls, 'rep',rep);
    elseif strcmp(cluName,'GHPKM')==1
        st=ones(numOfCls,nFea,rep);
        for j=1:rep
            st(:,:,j) =start;
        end
        %[IDX,C] =kmeans(pFea,numOfCls,'Start',st,'Distance',distance);
        [IDX,C] =GHPKM(pFea,numOfCls,k_ocurrence,'start',st,'distance',distance);

    end

    silh = silhouette(feature,IDX);
    silh=sum(silh)/nSam;
    iterSilh(1,i)=silh;
    sumSilh=sumSilh+silh;
end
%end cluster...
avgSilh=sumSilh/times;
end
