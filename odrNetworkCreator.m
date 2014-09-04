%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

%% ODRNetworkCreator: The trainer for a single ODR network object
function [networks] = ODRNetworkCreator(numInputs, numHiddenUnits, epsilon, numIterations)

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

    % Call 'local' cluster to initialise it
    parcluster('local');

    % Check pool status
    poolSize = matlabpool('size');
    if (poolSize ~= 8)
        if (poolSize ~= 0)
            % If there are more/less than 8 workers, close the current pool
            matlabpool('close');
        end % Else, there is no pool

        % Create pool with 8 workers/threads
        matlabpool('open', 8);
    end

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
    matlabpool('close');

    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
