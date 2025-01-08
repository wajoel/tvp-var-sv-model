function corrMatrix = tsCorrelation(data, commoditySet)
    % Function to compute the correlation matrix for a selected set of assets
    % Inputs:
    %   logReturnsTable: A table containing log returns with assets as columns
    %   commoditySet: Cell array of asset names (columns in logReturnsTable)
    % Output:
    %   corrMatrix: Correlation matrix for the selected assets

    % Ensure the commoditySet assets exist in the table
    missingAssets = setdiff(commoditySet, data.Properties.VariableNames);
    if ~isempty(missingAssets)
        error('The following assets are missing from the logReturnsTable: %s', strjoin(missingAssets, ', '));
    end

    % Extract log returns for the selected commodities
    selectedReturns = data{:, commoditySet};

    % Compute the correlation matrix
    corrMatrix = corrcoef(selectedReturns);
end
