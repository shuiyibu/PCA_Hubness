path='/Users/langdylan/MasterArticle/Code/result/Nor/';
lp=[5,1,2];

legends={};
for i=1:length(lp)
    %save figure
    overallSNk=strcat(path,num2str(lp(i)));
    scrsz = get(0,'ScreenSize');
    figure('Position',[0 30 scrsz(3) scrsz(4)-95]);
    filePath=fullfile(path,strcat('*',num2str(lp(i)),'_skew.mat'));
    files=dir(filePath);
    len=length(files);
    
    for j=1:len
        names=files(j).name;
        fileName=strcat(path,names);
        data=load(fileName);
        skews=data.skews;
        names=strsplit(files(j).name,'_');
        
        legends(j)=names(1);
        
        
        %         x=100*[1:skews.nFea]/skews.nFea;
        %         y=skews.value;
        
        plot(100*[1:skews.nFea]/skews.nFea,skews.value);
        xlabel('Features (%)'); % x-axis label
        ylabel('Skewness'); % y-axis label
        
        
        
        hold on;
        
        
    end
    legend(legends);
    saveas(gcf,overallSNk,'jpg');
    hold off;
    
    
    
end
