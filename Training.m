%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

clc
clear all
close all force

TESTED_DIGIT = 3;
OTHER_DIGITS = [0, 1, 2, 4, 5, 6, 7, 8, 9];

EPSILON = 0.01;
NUM_PASSES = 20000;
NUM_INPUTS = 200;
NUM_HIDDEN_UNITS = 20;

network = Network(NUM_INPUTS, NUM_HIDDEN_UNITS);

fprintf('Initialized a network with %d inputs and %d hidden units.\n', NUM_INPUTS, NUM_HIDDEN_UNITS);

% matlabpool('open',4);

fprintf('Training, please wait.\n');

for pass = 1:NUM_PASSES
    % Learned digit
    sampleNum = randi([1,13],1,1);
    [X, Y] = getSample(TESTED_DIGIT, sampleNum);
    network.learn([X, Y], 1, EPSILON);

    % Other digits
    sampleNum = randi([1,13],1,1);
    % digit = randi([1,9],1,1);
    % [X, Y] = getSample(digit, sampleNum);
    digitPos = randi(length(OTHER_DIGITS));
    [X, Y] = getSample(OTHER_DIGITS(digitPos), sampleNum);
    network.learn([X, Y], 0, EPSILON);

    if(rem(pass, (NUM_PASSES/10)) == 0)
        fprintf('Trained %d times.\n', pass);
    end
end

% matlabpool('close');

fprintf('Training complete, please enter digits to test.\n');

while 1
    try
        [X, Y] = getUserTraj();
        [X, Y] = scaleSample(X, Y);
        confidence = network.getOutput([X, Y]);
        fprintf('Confidence level of the entered digit to be "%d" = %f\n', TESTED_DIGIT, confidence);
    catch err
        fprintf('An error ocurred when getting trajectory, please try again:\n');
    end
end
