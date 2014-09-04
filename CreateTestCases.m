%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

clc
clear all
close all force

fprintf('Welcome to test case file generator, created by A. Emre Unal.\n');

digit = input('Please enter the digit you want to create test files for: ');
numTestCases = input('Please enter the number of test cases you want to create: ');

fName = sprintf('mid1test/test%d.txt', digit);

fileID = fopen(fName, 'w');

if(fileID == -1)
    mkdir('mid1test');
    fileID = fopen(fName, 'w');
end

% testCases = [];

for i = 1:numTestCases
    while (1)
        try
            [X, Y] = getUserTraj();
            if (input('(Did you draw it correctly? Yes=1 / No=0): ') == 1)
                break
            end
        catch err
            fprintf('An error ocurred while getting trajectory, please try again.');
        end
    end
    % testCases(i) = [X, Y];
    testCase = sprintf('  %1.7e', [X, Y]);
    testCase = strrep(testCase, 'e+','e+0');
    testCase = strrep(testCase, 'e-','e-0');
    fprintf(fileID, testCase);
    % fseek(fileID, -2, 'eof'); % Go back 2 bytes to remove last 2 spaces
    fprintf(fileID, '\n');
end

fclose(fileID);

fprintf('Test file successfully created.\n');

clear all
close all force
