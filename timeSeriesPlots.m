function timeSeriesPlots(data, timeColumn, titleText, xLabelText, yLabelText)
    % Plot the evolution of data for each column over time.
    %
    % Inputs:
    %   data - Table containing the data to plot.
    %   timeColumn - Name of the column representing time (e.g., 'Date').
    %   titleText - Title for the plot.
    %   xLabelText - Label for the x-axis.
    %   yLabelText - Label for the y-axis.
    
    % Check if the time column is in datetime format
    if ~isdatetime(data.(timeColumn))
        error('The time column must be in datetime format.');
    end

    % Create a new figure
    figure('Position', [100, 100, 1200, 600]);

    % Loop through each column except the time column
    for i = 1:width(data)
        if ~strcmp(data.Properties.VariableNames{i}, timeColumn)
            % Plot the data
            plot(data.(timeColumn), data{:, i}, 'DisplayName', data.Properties.VariableNames{i});
            hold on; % Keep previous plots
        end
    end

    % Add title, labels, and legend
    title(titleText);
    xlabel(xLabelText);
    ylabel(yLabelText);
    legend('show');
    
    % Rotate x-axis labels for better readability
    xtickangle(45);

    % Finalize the plot
    hold off;
end
