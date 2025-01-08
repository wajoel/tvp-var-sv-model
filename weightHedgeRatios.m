function [weights, hedgeRatios] = weightHedgeRatios(covMat, volOil, volFood, covOilFood)
    % Compute optimal portfolio weights and hedge ratios
    
    weights = max(0, min(1, (volOil - covOilFood) ./ (volFood - 2 * covOilFood + volOil)));
    hedgeRatios = covOilFood ./ volFood;
end
