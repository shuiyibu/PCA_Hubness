%load data function
    function [data]=loadData(loadDataPath,loadDataName)
        file=strcat(loadDataPath,loadDataName);
        data=xlsread(file);
    end
