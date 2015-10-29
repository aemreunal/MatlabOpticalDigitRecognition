%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

%% ODRNetworkCreator: The trainer for a single ODR network object
function [networks] = ODRNetworkCreator(numInputs, numHiddenUnits, epsilon, numIterations)

    NUM_WORKERS = 4;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    %% Create individual networks
    %%

    networks = [];

    for i = 1:10
        networks = [networks, Network(numInputs, numHiddenUnits)];
    end

    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fprintf('Initialized networks with %d inputs, %d hidden units (epsilon = %f, num. iterations = %d).\n', numInputs, numHiddenUnits, epsilon, numIterations);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    %% Open parallel computing pool and sample files, train networks,
    %% then close the samples & pool
    %%

    % Create a pool with NUM_WORKERS workers/threads at 'local' cluster
    % trainingPool = parpool('local', NUM_WORKERS);

    % Create a pool with NUM_WORKERS workers/threads
    trainingPool = parpool(NUM_WORKERS);

    % Training
    parfor i = 1:10

        % Open sample files
        % (This needs to be done inside the parfor because otherwise, the workers
        % can't access the global samples opened outside the parfor)
        samples = [];

        samples(1) = fopen('mid1data/dataZero.txt');
        samples(2) = fopen('mid1data/dataOne.txt');
        samples(3) = fopen('mid1data/dataTwo.txt');
        samples(4) = fopen('mid1data/dataThree.txt');
        samples(5) = fopen('mid1data/dataFour.txt');
        samples(6) = fopen('mid1data/dataFive.txt');
        samples(7) = fopen('mid1data/dataSix.txt');
        samples(8) = fopen('mid1data/dataSeven.txt');
        samples(9) = fopen('mid1data/dataEight.txt');
        samples(10) = fopen('mid1data/dataNine.txt');

        % Train the network
        networks(i) = getTrainedNetwork(networks(i), (i - 1), epsilon, numIterations, samples);

        % Close sample files
        for j = 1:10
            fclose(samples(j));
        end

    end

    % Close the parallel computing pool
    delete(trainingPool)

    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
