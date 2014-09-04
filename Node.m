%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

classdef Node < handle

    properties
        numInputs
        weights
    end

    methods
        % Constructor
        function [obj] = Node(numInputs)
            obj.numInputs = numInputs;
            obj.weights = (rand(numInputs, 1) / 1000);
        end

        % Main output function
        function [output, weightedSum] = getOutput(obj, inputs)
            weightedSum = obj.getWeightedSum(inputs);
            output = obj.sigmoid(weightedSum);
        end

        % Calculate weighted sum of inputs
        function [result] = getWeightedSum(obj, inputs)
            result = inputs * obj.weights;
        end

        % Sigmoid function
        function [result] = sigmoid(~, x)
           result = 1 / (1 + exp(-x));
        end
    end

end
