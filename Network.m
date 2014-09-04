%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

classdef Network < handle

    properties
        numInputs
        numHiddenUnits
        hiddenUnits = [];
        outputUnit
    end

    methods
        % Constructor
        function [obj] = Network(numInputs, numHiddenUnits)
            obj.numInputs = numInputs;
            obj.numHiddenUnits = numHiddenUnits;

            obj.outputUnit = Node(numHiddenUnits);
            for i = 1:numHiddenUnits
                obj.hiddenUnits = [obj.hiddenUnits, Node(numInputs)];
            end
        end

        % Main output function
        function [output] = getOutput(obj, inputs)
            hiddenUnitOutputs = arrayfun(@(x) x.getOutput(inputs), obj.hiddenUnits);
            output = obj.outputUnit.getOutput(hiddenUnitOutputs);
        end

        % Teach the network
        function learn(obj, inputs, expectedOutput, epsilon)
            % Forward pass phase
            [hiddenUnitInputs, hiddenUnitOutputs] = obj.getHiddenUnitValues(inputs);
            [output, outputUnitInput] = obj.outputUnit.getOutput(hiddenUnitOutputs);
            % Backward pass phase
            outputDelta = [expectedOutput - output] * obj.sigmoidDeriv(outputUnitInput);
            hiddenDeltas = obj.getHiddenDeltas(hiddenUnitInputs, outputDelta);
            % Update phase
            obj.updateOutputUnitWeights(outputDelta, hiddenUnitOutputs, epsilon);
            obj.updateHiddenUnitWeights(hiddenDeltas, inputs, epsilon);
        end
    end

    methods(Access = private)
        %% getHiddenUnitValues: calculate the weighted sum hidden inputs and sigmoid outputs
        function [hiddenUnitInputs, hiddenUnitOutputs] = getHiddenUnitValues(obj, inputs)
            hiddenUnitInputs = [];
            hiddenUnitOutputs = [];
            for i = 1:obj.numHiddenUnits
                [output, weightedSum] = obj.hiddenUnits(i).getOutput(inputs);
                hiddenUnitInputs(i) = weightedSum;
                hiddenUnitOutputs(i) = output;
            end
        end

        %% getHiddenDeltas: calculate hidden unit delta values
        function [hiddenDeltas] = getHiddenDeltas(obj, hiddenUnitInputs, outputDelta)
            hiddenDeltas = [];
            for i = 1:obj.numHiddenUnits
                delta = obj.sigmoidDeriv(hiddenUnitInputs(i));
                delta = delta * obj.outputUnit.weights(i);
                delta = delta * outputDelta;
                hiddenDeltas(i) = delta;
            end
        end

        %% sigmoidDeriv: the derivative of the sigmoid function
        function [output] = sigmoidDeriv(obj, x)
            output = ((1 / (1 + exp(-x))) * (1 - (1 / (1 + exp(-x)))));
        end

        %% updateOutputUnitWeights: updates the weights of the output unit
        function updateOutputUnitWeights(obj, outputDelta, hiddenUnitOutputs, epsilon)
            for i = 1:obj.numHiddenUnits
                update = epsilon * outputDelta * hiddenUnitOutputs(i);
                obj.outputUnit.weights(i) = obj.outputUnit.weights(i) + update;
            end
        end

        %% updateHiddenUnitWeights: function description
        function updateHiddenUnitWeights(obj, hiddenDeltas, inputs, epsilon)
            % units = obj.hiddenUnits;
            % parfor i = 1:obj.numHiddenUnits
            for i = 1:obj.numHiddenUnits
                for j = 1:obj.numInputs
                    update = epsilon * hiddenDeltas(i) * inputs(j);
                    % units(i).weights(j) = units(i).weights(j) + update;
                    obj.hiddenUnits(i).weights(j) = obj.hiddenUnits(i).weights(j) + update;
                end
            end
            % obj.hiddenUnits = units;
        end
    end

end
