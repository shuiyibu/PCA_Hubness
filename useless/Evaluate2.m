function [ silh,iterSilh,times ] = Evaluate2( fea,data,times,K ,start)
%EVALUATE Summary of this function goes here
%   Detailed explanation goes here

% nVarargs = length(varargin);
% fprintf('Inputs in varargin(%d):\n',nVarargs);
% disp(varargin);


silh=0;

[nSam,nFea]=size(fea);
iterSilh=zeros(1,times);
rep=5;
st=ones(K,nFea,rep);

if strcmp(start,'non')~=1
    for i=1:rep
        st(:,:,i) =start;
    end
    
end
startTime=tic;
lastTime=0;
iterTimes=zeros(times,1);
for i=1:times
    
    if strcmp(start,'non')==1
        [IDX,C] =GHPKM(fea,K, 'rep',rep);
    else
        [IDX,C] =GHPKM(fea,K,'start',st, 'rep',rep);
    end
    
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
