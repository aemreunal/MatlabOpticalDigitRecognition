%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

%% getTrainedNetwork: The trainer for a single ODR network object
function [trainedNetwork] = getTrainedNetwork(network, digitToLearn, EPSILON, NUM_PASSES, samples)

    CORRECT = 1;
    WRONG = 0;

    fprintf('Digit %d training starting, please wait.\n', digitToLearn);

    iteration = 0;
    trainedNetwork = network;

    for pass = 1:NUM_PASSES

        % Learned digit
        sampleNum = randi([1,13],1,1);

        [X, Y] = getSample(samples(digitToLearn + 1), sampleNum);

        trainedNetwork.learn([X, Y], CORRECT, EPSILON);

        % Other digits
        otherDigit = getOtherRandDigit(digitToLearn);
        sampleNum = randi([1,13],1,1);

        [X, Y] = getSample(samples(otherDigit + 1), sampleNum);

        trainedNetwork.learn([X, Y], WRONG, EPSILON);

        if(rem(pass, (NUM_PASSES/10)) == 0)
            iteration = iteration + 1;
            fprintf('Digit %d training %d/10 complete.\n', digitToLearn, iteration);
        end
    end

    fprintf('Digit %d training complete.\n', digitToLearn);

end
