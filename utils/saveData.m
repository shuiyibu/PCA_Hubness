
%save data function
function []=saveData(saveDataPath,saveDataName,data)
file=strcat(saveDataPath,saveDataName);
csvwrite(file,data);
end
