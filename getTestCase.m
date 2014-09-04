%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

function [X, Y] = getTestCase(digit, testCaseNum)
%GETTESTCASE CS 454 MT1 example test case data grabber
% testCaseNum = [1:10]

    fileDim = [200 10];
    formatSpec = '%f';

    fileID = fopen(sprintf('mid1test/test%d.txt', digit));

    values = fscanf(fileID,formatSpec,fileDim);

    fclose(fileID);

    values = values';

    [X, Y] = scaleSample(values(testCaseNum,1:100), values(testCaseNum,101:200));
end
