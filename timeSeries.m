function timeSeries(data)
    % Extract variable names and dates
    variableNames = data.Properties.VariableNames;
    dates = data.Date; % Assuming 'Date' column exists in 'data'
    numVariables = width(data) - 1; % Exclude the 'Date' column

    % Define grid layout (rows x columns)
    numRows = ceil(sqrt(numVariables));
    numCols = ceil(numVariables / numRows);

    % Create a figure and set size
    figure('Units', 'normalized', 'OuterPosition', [0, 0, 1, 1]);

    % Generate subplots
    for i = 2:numVariables+1
        subplot(numRows, numCols, i-1); % Subplot index
        plot(dates, data{:, i}, 'k', 'LineWidth', 1.2); % Time series plot in black
        ylabel(variableNames{i}, 'Interpreter', 'none', 'FontSize', 10);
        xlabel('Date', 'FontSize', 10);
        set(gca, 'FontSize', 8, 'Box', 'on'); % Adjust font and box
    end

    % Add title
    % sgtitle('Time Series of Prices', 'FontSize', 12, 'FontWeight', 'bold');
end
