%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

function [X, Y] = getSample(sampleFileID, sampleNum)
%SCALESAMPLE CS 454 MT1 example sample data grabber
% sampleNum = [1:13]
    sizeA = [200 13];
    formatSpec = '%f';

    values = fscanf(sampleFileID,formatSpec,sizeA);
    frewind(sampleFileID);

    values = values';

    [X, Y] = scaleSample(values(sampleNum,1:100), values(sampleNum,101:200));
end
