function [ otherDigit ] = getOtherRandDigit( digit )
%GETOTHERRANDDIGIT Get a digit other than 'digit' argument

    while 1
        otherDigit = randi([0,9],1,1);
        if(otherDigit ~= digit)
            break
        end
    end

end

