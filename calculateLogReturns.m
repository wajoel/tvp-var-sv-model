function logReturnsTable = calculateLogReturns(data, nonNumericColumn)
    % Calculate log-returns for all numeric columns in the given dataset.
    %
    % Inputs:
    %   data - Table containing the dataset
    %   nonNumericColumn - Name of the non-numeric column to exclude (e.g., 'Date')
    %
    % Output:
    %   logReturnsTable - Table with log-returns and the non-numeric column

    % Ensure the non-numeric column is in the correct format
    if iscell(data.(nonNumericColumn)) || ischar(data.(nonNumericColumn))
        data.(nonNumericColumn) = datetime(data.(nonNumericColumn), 'InputFormat', 'yyyy/MM/dd');
    end

    % Extract numeric columns and compute log-returns
    numericData = data(:, setdiff(data.Properties.VariableNames, {nonNumericColumn}));
    logReturns = varfun(@(x) [NaN; diff(log(x))], numericData);

    % Combine non-numeric column with log-returns
    logReturnsTable = [data(:, nonNumericColumn), logReturns];
end
