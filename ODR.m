%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

clc
clear all
close all force

NUM_INPUTS = 200;

EPSILON = 0.01;
NUM_ITERATIONS = 20000; % Usually >10,0000
NUM_HIDDEN_UNITS = 20; % Usually >10

LOAD_NETWORK = 1;
CREATE_NETWORK = 2;

fprintf('Welcome to Optical Digit Recognition network, created by A. Emre Unal.\n');
fprintf('Would you like to use a pre-existing network (enter "1"), create one (enter "2") or exit (enter "0")?\n');
fprintf('(To load a network, you have to have a file called "networks")\n');

choice = input('Choice?: ');

% Choice 1 & 2 are valid, rest is EXIT
if(choice ~= LOAD_NETWORK && choice ~= CREATE_NETWORK)
    fprintf('Goodbye!\n');
    clear all
    return
end

if (choice == LOAD_NETWORK)
    clear networks;
    load networks;

    fprintf('Loading complete.\n');

elseif(choice == CREATE_NETWORK)
    NUM_HIDDEN_UNITS = input('Enter number of hidden units: ');
    NUM_ITERATIONS = input('Enter number of learning iterations: ');

    networks = odrNetworkCreator(NUM_INPUTS, NUM_HIDDEN_UNITS, EPSILON, NUM_ITERATIONS);

    % Saving the network by saving the 'networks' object
    save(getSaveFileName(NUM_HIDDEN_UNITS, NUM_ITERATIONS), 'networks');

    fprintf('Training complete.\n');

end

fprintf('Please enter digits to test.\n');

while (1)
    try

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%
        %% Get user drawing and guess it
        %%

        [X, Y] = getUserTraj();
        [X, Y] = scaleSample(X, Y);

        confidences = [];

        for i = 1:10
            confidences(i) = networks(i).getOutput([X, Y]);
        end

        [confidence, maxIndex] = max(confidences);

        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        fprintf('This digit is "%d" with %f confidence.\n', (maxIndex - 1), confidence);
        fprintf('Was the guess correct?\n');
        fprintf('(Enter "10" for correct guess, otherwise enter the actual digit)\n');
        fprintf('(Enter "-2" if you drew wrong)\n');
        fprintf('(Enter "-1" to exit)\n');

        correctness = input(': ');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%
        %% Check correctness and train networks accordingly
        %%

        if(correctness == 10)
            % Guess is correct
            for i = 1:10
                if(i == maxIndex)
                    % Congratulate the correct network
                    networks(i).learn([X, Y], 1, EPSILON);
                else
                    % Congratulate other networks
                    networks(i).learn([X, Y], 0, EPSILON);
                end
            end
        elseif (correctness ~= 10 && correctness ~= -1 && correctness ~= -2)
            % Guess is incorrect

            % Teach actual digit's network
            networks(correctness + 1).learn([X, Y], 1, EPSILON);
            % Scold false digit's network
            networks(maxIndex).learn([X, Y], 0, EPSILON);
        elseif (correctness == -1)
            % User is bored and wants to leave
            fprintf('There was further learning. Would you like to save the network?\n');
            if(input('(Enter "1" to save): ') == 1)
                save(getSaveFileName(NUM_HIDDEN_UNITS, NUM_ITERATIONS), 'networks');
            end
            break
        end

        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    catch err
        fprintf('An error ocurred when getting trajectory, please try again:\n');
    end
end

fprintf('Goodbye!\n');
