function plotHistograms(logReturnsTable)
    % Extract variable names, excluding 'Date'
    variableNames = logReturnsTable.Properties.VariableNames;
    
    % Find the index of 'Date' column and remove it
    dateIndex = find(strcmp(variableNames, 'Date'));
    if ~isempty(dateIndex)
        variableNames(dateIndex) = []; % Remove 'Date' column
        logReturnsTable(:, dateIndex) = []; % Remove 'Date' column
    end
    
    % Number of variables to plot (excluding 'Date')
    numVariables = width(logReturnsTable);
   
    % Define grid layout (rows x columns)
    numRows = ceil(sqrt(numVariables));
    numCols = ceil(numVariables / numRows);

    % Create a figure and set size
    figure('Units', 'normalized', 'OuterPosition', [0, 0, 1, 1]);

    % Generate subplots
    for i = 1:numVariables
        subplot(numRows, numCols, i); % Subplot index
        histogram(logReturnsTable{:, i}, 20); % Histogram with 20 bins
        xlabel(variableNames{i}, 'Interpreter', 'none', 'FontSize', 10);
        ylabel('Frequency', 'FontSize', 10);
        set(gca, 'FontSize', 8, 'Box', 'on'); % Adjust font and box
    end

    % Add title
   %  sgtitle('Histograms of Returns', 'FontSize', 12, 'FontWeight', 'bold');
end
