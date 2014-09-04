%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

clc
clear all
close all force

networkCases = cellstr(['5-10000 '; '5-20000 '; '10-10000'; '10-20000'; '15-10000'; '15-20000'; '20-10000'; '20-20000'; '25-10000'; '25-20000'; '25-30000'; '25-35000'; '30-20000']);

errors = [];

fprintf('Welcome to Optical Digit Recognition network cross-validation test, created by A. Emre Unal.\n');

for networkNum = 1:length(networkCases)
    % Load networks
    clear('networks');
    load(sprintf('network-%s.mat', char(networkCases(networkNum))));

    errors(networkNum) = 0;

    for digit = 0:9
        for testCaseNum = 1:10
            [X, Y] = getTestCase(digit, testCaseNum);

            % Go through each sub-network
            for testedSubNetwork = 1:10
                output = networks(testedSubNetwork).getOutput([X, Y]);

                if(testedSubNetwork == (digit + 1)) % If it is the correct network
                    errors(networkNum) = errors(networkNum) + (1 - output)^2;
                else
                    errors(networkNum) = errors(networkNum) + (0 - output)^2;
                end
            end
        end
    end

    fprintf('SSE for network-%s is: %f\n', char(networkCases(networkNum)), errors(networkNum));
end

[lowestError, index] = min(errors);
fprintf('Network "%s" has the lowest error with E=%f.\n', char(networkCases(index)), errors(index) );
