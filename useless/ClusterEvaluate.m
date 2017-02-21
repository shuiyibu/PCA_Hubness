function [ silh,iterSilh,times ] =ClusterEvaluate(fea,data,times,K,k_ocurrence,start,algo)
%EVALUATE Summary of this function goes here
%   Detailed explanation goes here

% nVarargs = length(varargin);
% fprintf('Inputs in varargin(%d):\n',nVarargs);
% disp(varargin);


silh=0;

[nSam,nFea]=size(fea);
iterSilh=zeros(1,times);
rep=5;



startTime=tic;
lastTime=0;
iterTimes=zeros(times,1);
for i=1:times
    if strcmp(algo,'kmeans')==1
        [IDX,C] =kmeans(fea,K, 'rep',rep);
    elseif strcmp(algo,'LPPKmeans')==1
        %         [IDX,C] =kmeans(fea,K,'start',st, 'rep',rep);
        [IDX,C] =kmeans(fea,K, 'rep',rep);
    else
        st=ones(K,nFea,rep);
        for j=1:rep
            st(:,:,j) =start;
        end
%         [IDX,C] =kmeans(fea,K,'start',st, 'rep',rep);
        [IDX,C] =GHPKM(fea,K,k_ocurrence,'start',st, 'rep',rep);

    end


    %     if strcmp(algo,'kmeans')==1
    %         [IDX,C] =kmeans(fea,K, 'rep',rep);
    %     elseif strcmp(algo,'LPPKmeans')==1
    %         %         [IDX,C] =kmeans(fea,K,'start',st, 'rep',rep);
    % %         disp('LPPKmeans');
    %         [IDX,C] =kmeans(fea,K, 'rep',rep);
    %
    %     else
    %         %         strcmp(k_ocurrence,'LHKmeans')==1
    % %         disp('LHKmeans');
    %         [IDX,C] =GHPKM(fea,K,k_ocurrence,'start',st, 'rep',rep);
    %     end
    %

    s = silhouette(data,IDX);
    s=sum(s)/nSam;
    %     res(1,i)=i;
    iterSilh(1,i)=s;
    silh=silh+s;
    tempTime=toc(tic);
    iterTimes(i,1)=tempTime-lastTime;
    lastTime=tempTime;

end
silh=silh/times;
% fprintf('s=%d\n',silh);
totalTime=toc(startTime);
times=[];
times.totalTime=totalTime;
times.iterTimes=iterTimes;
end

% function =algos()
%
% end
