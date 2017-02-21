function [] = Preprocess( loadDataPath,loadDataName,names )
addpath(genpath(pwd));

%load data
[data]=loadData(loadDataPath,loadDataName);
savepath='/Users/langdylan/MasterArticle/Code/result/';

%
name='SN_20';
dire=strcat(savepath,name,'/')
if ~exist(dire,'dir')==1
    mkdir(dire);
end
nr=regexp(loadDataName, '\.', 'split');
dataName=nr{1};
name=strcat(dire,dataName,'_');
resName=name;
label=data(:,end);
feature=data(:,1:end-1);
fea=repmat(feature,1);
[nSize,nFea]=size(fea);


% if row == 1, normalize each row of fea to have unit norm;
% if row == 0, normalize each column of fea to have unit norm;
% row=0;
% fea = NormalizeFea(fea,row);
% num of clusters
% K=2;
numOfCls=length(unique(label));
times=3;
idk=0;
s1=0;s2=0;s3=0;
isSave=0;
preAlgoNames=names.preAlgoNames;
numOfPreAlgoNames=length(preAlgoNames);

maxSilh=0;
minK=5; maxK=20;
optimalK=minK;
isSkew=0;

res=[];
% preprocess start...
distances=names.distances;
numOfDistances=length(distances);
preName=name;
distance_P=2;

maxFea=floor(nFea/3);
for p=1:numOfDistances
    if strcmp(distances{p},'cityblock')==1
        distance_P=1;
    end

    name=strcat(preName,'minkowski_',num2str(distance_P));
    name=strrep(name,'.','');
    for n=1:numOfPreAlgoNames
        preAlgoName=preAlgoNames(n);
        res.name(n)=preAlgoName;
        skews=[];

        %%choose best k
        for k=minK:maxK%k refers to num-of-kNearestNeighbour
            skews.name=preAlgoName;
            skews.nFea=nFea;
            skews.value=[];

            %reduce skewness to 80%
            originalSN=0;


            for reductToD=0:maxFea

                [pFea,k_ocurrence,skew]=PreprocessAlgos(preAlgoName,fea,k, reductToD,distance_P);
               % disp(skew);
                if reductToD==0
                    titleName=num2str(skew);
                    originalSN=skew;
                end
                %             skews.k(k-minK+1,reductToD)=k;
                %             skews.skew(k-minK+1,reductToD)=skew;

                skews.value=[skews.value skew];
                skews.reductToD=reductToD;


                if (reductToD>0 && originalSN*0.8 > skew)||(reductToD==maxFea)

                    % cluster start
                    cluAlgoNames=names.cluAlgoNames;
                    numOfCluAlogNames=length(cluAlgoNames);
                    silhs=[];
                    for m=1:numOfCluAlogNames
                        cluAlgoName=cluAlgoNames(m);

                        %

                        [silh,iterSilh] = ClusterAlgos(cluAlgoName,pFea,numOfCls,times,k_ocurrence,feature,distances{p});

%                         disp(silh);
                        if silh>maxSilh
                            maxSilh=silh;
                            optimalK=k;
                            res.silh=silh;
                            res.optimalK=k;
                            res.skew=skew;
                            res.distance=distances{p};
                        end
                        silhs.name=cluAlgoName;
                        silhs.silh=silh;
                        silhs.iterSilh=iterSilh;
                        silhs.maxSilh=maxSilh;
                        silhs.optimalK=optimalK;
                        %                     end%numOfDistances
                    end
                    % cluster end

                   reductToD==maxFea;% exit this loop
                end

            end %reductToD

            if isSkew==1
                x=100*[1:skews.nFea]/skews.nFea;
                y=skews.value;
                %             xs={xs x};
                %             ys={ys y};
                %
                %save figure
                scrsz = get(0,'ScreenSize');
                figure('Position',[0 30 scrsz(3) scrsz(4)-95]);
                plot(x,y);
                title(titleName);
                xlabel('Features (%)'); % x-axis label
                ylabel('Skewness'); % y-axis label
                skewName=strcat(name,'_skew');
                saveas(gcf,skewName,'jpg');
                save(strcat(skewName,'.mat'),'skews');
            end
        end
    end
end %numOfDistanceP
% preprocess end....

save(strcat(resName,'.mat'),'res');
fprintf('\noptimalK=%d, maxSilh=%f \n-----------------------------------------\n',optimalK,maxSilh);
% isSave=1;
% idk=18;
% [res ]=LPP_KmeanswithHubcluster( feature,fea,idk,K ,label,loadDataName,isSave,times);
% iterSilh=res.iterSilh;





%
% x=1:times;
% y1=iterSilh(1,:);
% y2=iterSilh(2,:);
% y3=iterSilh(3,:);
% plot(x,y1,x,y2,x,y3);
% legend('kmeans','LPPKmeans','LPPHK');
%
% saveas(gcf,name,'jpg');
% clear all; clc; close all;
end
