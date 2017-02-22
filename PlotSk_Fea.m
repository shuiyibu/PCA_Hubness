path='/Users/langdylan/MasterArticle/Code/result/Skewness/NorFalse/';
%lp=[5,1,2];
lp=[2];
legends={};

for i=1:length(lp)
    %save figure
    overallSNk=strcat(path,num2str(lp(i)));
    scrsz = get(0,'ScreenSize');
    figure('Position',[0 30 scrsz(3) scrsz(4)-95]);
    filePath=fullfile(path,strcat('*',num2str(lp(i)),'_skew.mat'));
    files=dir(filePath);
    len=length(files);
    SNValues=zeros(1,len);
    for j=1:len
        names=files(j).name;
        fileName=strcat(path,names);
        data=load(fileName);
        skews=data.skews;
        names=strsplit(files(j).name,'_');

        legends(j)=names(1);
        values=skews.value
        SNValues(1,j)=values(1);
        %skewsValue(j)=skews;

        %         x=100*[1:skews.nFea]/skews.nFea;
        %         y=skews.value;




    end
    %sort by skewness descend
    [SNValue,SNIndex]=sort(SNValues,'descend');
    copyLegends={};
    for sj=1:len-2
        copyLegends(sj)=legends(SNIndex(sj));
        names=files(SNIndex(sj)).name;
        fileName=strcat(path,names);
        data=load(fileName);
        skews=data.skews;
        x=100*[1:skews.nFea]/skews.nFea;
        y=skews.value;
        scale=0.95;
        x=x(1:floor(scale*length(x)));
        y=y(1:floor(scale*length(y)));
        plot(x,y);
        xlabel('Features (%)'); % x-axis label
        ylabel('Skewness'); % y-axis label



        hold on;
    end

    legend(copyLegends);
    saveas(gcf,overallSNk,'jpg');
    hold off;



end
