function decimal = bin2int(binaryNumberArray, targetBits)
    r = zeros([1, length(binaryNumberArray)]);
    parfor ii = 1:length(binaryNumberArray)

        decimalValue = 0;
        for j = targetBits-1:-1:0
            bitValue = mod(floor(binaryNumberArray(ii) / (10^j)),10); % Get current bit
            decimalValue = decimalValue + bitValue * 2^(j);
        end

        if (decimalValue >= 2^(targetBits-1))
            decimalValue = -(2^(targetBits) - decimalValue);
        end

        r(ii) = decimalValue;

    end
    decimal = r;
end