%
% This code belongs to:
% Ahmet Emre Unal
% S001974
% emre.unal@ozu.edu.tr
%

function [scaledX, scaledY] = scaleSample(X, Y)
%SCALESAMPLE CS 454 MT1 example data scaling between 0 and 1

    rangeX = range(X);
    rangeY = range(Y);

    globalMin = 0;
    globalRange = 0;

    if(rangeX > rangeY)
        globalMin = min(X);
        globalRange = rangeX;
    else
        globalMin = min(Y);
        globalRange = rangeY;
    end

    scaledX = X - globalMin;
    scaledX = (scaledX / globalRange);

    scaledY = Y - globalMin;
    scaledY = (scaledY / globalRange);

end
