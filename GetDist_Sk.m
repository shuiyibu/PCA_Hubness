function [Nk] = GetDist_Sk(data,distance_P,k)
[nSam,nFea]=size(data);
D=pdist(data,'minkowski',distance_P);

dist=squareform(D);
[sData,sIndex]=sort(dist,2);

Nk=zeros(nSam,1);
for n=1:nSam
    for i=2:k
        Nk(sIndex(n,i),1)=Nk(sIndex(n,i),1)+1;
    end
end
end
