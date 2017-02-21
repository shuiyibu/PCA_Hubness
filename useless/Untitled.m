% addpath(genpath(pwd));
%
% X = [randn(20,2)+ones(20,2); randn(20,2)-ones(20,2)];
% [cidx, ctrs] = kmeans(X, 2, 'dist','city', 'rep',5, 'disp','final');
% plot(X(cidx==1,1),X(cidx==1,2),'r.', ...
%     X(cidx==2,1),X(cidx==2,2),'b.', ctrs(:,1),ctrs(:,2),'kx');
% label=[1 2 3 4 4 4 1 2 3  ];
% len=length(label);
% category=[];
% for i=1:len
%     category(end+1)=
% end

file ='/Users/langdylan/MasterArticle/Code/dataset/Arcene/Arcene.xlsx';
X=xlsread(file);
[nSam,nFea]=size(X);
for i=1:nSam
    for j=1:nFea
        if isnumeric(X(i,j))~=1
            fprintf('%d  %d\n',i,j);            
        end
    end
end