function [ fileName ] = getSaveFileName(numHiddenUnits, numPasses)
%GETSAVEFILENAME Get name of save file.
    timeNow = clock;
    fileName = strcat('network-', int2str(timeNow(3)));
    fileName = strcat(fileName, '-');
    fileName = strcat(fileName, int2str(timeNow(2)));
    fileName = strcat(fileName, '-');
    fileName = strcat(fileName, int2str(timeNow(1)));
    fileName = strcat(fileName, '-');
    fileName = strcat(fileName, int2str(timeNow(4)));
    fileName = strcat(fileName, '-');
    fileName = strcat(fileName, int2str(timeNow(5)));
    fileName = strcat(fileName, '-');
    fileName = strcat(fileName, int2str(numHiddenUnits));
    fileName = strcat(fileName, '-');
    fileName = strcat(fileName, int2str(numPasses));
end

