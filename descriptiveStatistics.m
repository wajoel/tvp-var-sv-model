function statsTable = descriptiveStatistics(inputData)
    % Calculate descriptive statistics for the given dataset
    %
    % Inputs:
    %   inputData - A table of numerical time series data (excluding non-numerical columns)
    %
    % Outputs:
    %   statsTable - A table summarizing key statistics for each numerical variable

    % Identify numeric columns
    numericVars = varfun(@isnumeric, inputData, 'OutputFormat', 'uniform');
    numericData = inputData(:, numericVars);
    variableNames = numericData.Properties.VariableNames;
    
    % Initialize arrays to store statistics
    meanVals = zeros(1, numel(variableNames));
    medianVals = zeros(1, numel(variableNames));
    stdVals = zeros(1, numel(variableNames));
    minVals = zeros(1, numel(variableNames));
    maxVals = zeros(1, numel(variableNames));
    missingVals = zeros(1, numel(variableNames));

    % Compute statistics for each numeric column
    for i = 1:numel(variableNames)
        colData = numericData.(variableNames{i});
        meanVals(i) = mean(colData, 'omitnan');
        medianVals(i) = median(colData, 'omitnan');
        stdVals(i) = std(colData, 'omitnan');
        minVals(i) = min(colData, [], 'omitnan');
        maxVals(i) = max(colData, [], 'omitnan');
        missingVals(i) = sum(isnan(colData));
    end

    % Combine results into a table
    statsTable = table(meanVals', medianVals', stdVals', minVals', maxVals', missingVals', ...
        'VariableNames', {'Mean', 'Median', 'StdDev', 'Min', 'Max', 'Missing'}, ...
        'RowNames', variableNames);

    % Display the table in the command window
    disp('Descriptive Statistics:');
    disp(statsTable);
end
