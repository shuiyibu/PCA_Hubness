clc;clear;
addpath(genpath(pwd));

loadDataPath='/Users/langdylan/MasterArticle/Code/dataset';
% loadDataName='Wpbc';
% --loadDataName='Parkinsons';
% loadDataName='Sonar';
% loadDataName='Wine';
% loadDataName='Spectrometer';
% loadDataName='Abalone';
% loadDataName='Arcene';%Input to EIG must not contain NaN or Inf.

maindir = loadDataPath;
% maindir = uigetdir( '???????' );
subdir  = dir( maindir );

for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' )||...
            isequal( subdir( i ).name, '..')||...
            ~subdir( i ).isdir)               % ?????????
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.xlsx' );
    xlsx = dir( subdirpath )               % ?????????xlsx???

% init PreprocessAlgos' names, ClusterAlgos' names
names=[];
names.preAlgoNames={'pca'};
names.cluAlgoNames={'GHPKM'};
% names.distance_P=[0.5,1,2];
names.distance_P=[2];
% names.distances={'sqeuclidean','cityblock'};
names.distances={'sqeuclidean'};
    for j = 1 : length( xlsx )
        xlsxpath = fullfile( maindir, subdir( i ).name, xlsx( j ).name);
        loadDataName=strcat(subdir( i ).name,'/',xlsx( j ).name);
        disp( strcat(loadDataPath,'/',subdir( i ).name,'/'));
        disp(xlsx( j ).name);
        Preprocess( strcat(loadDataPath,'/',subdir( i ).name,'/'),xlsx( j ).name ,names);
        %         fid = fopen( datpath );
        % ????????????? %
    end
end


disp('end');
