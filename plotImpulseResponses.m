%% plotImpulseResponses.m
function plotImpulseResponses(impulseResponses, horizons, variableNames, setIndex)
    % PLOTIMPULSERESPONSES Creates a grid of subplots for impulse responses.
    % 
    % Inputs:
    %   impulseResponses: 3D matrix [horizons x variables x time]
    %   horizons: Array of time horizons
    %   variableNames: Cell array of variable names
    %   setIndex: Index of the current commodity set

    % Dimensions
    [~, numVariables, numPeriods] = size(impulseResponses);

    % Ensure variableNames match the number of variables
    if length(variableNames) ~= numVariables
        warning('Mismatch between variableNames and impulseResponses. Using default names.');
        variableNames = arrayfun(@(x) sprintf('Variable %d', x), 1:numVariables, 'UniformOutput', false);
    end

    % Plot setup
    gridRows = ceil(sqrt(numVariables));
    gridCols = ceil(numVariables / gridRows);
    figure('Units', 'normalized', 'OuterPosition', [0 0 1 1], 'Name', sprintf('Commodity Set %d', setIndex));

    % Subplot generation
    for v = 1:numVariables
        subplot(gridRows, gridCols, v);
        hold on;

        % Plot impulse responses across time
        for t = 1:numPeriods
            plot(horizons, squeeze(impulseResponses(:, v, t)), 'LineWidth', 1.2);
        end

        title(variableNames{v}, 'Interpreter', 'none');
        xlabel('Months After Shock');
        ylabel('Standardized Response');
        grid on;
    end
    sgtitle(sprintf('Impulse Responses for Commodity Set %d', setIndex));
end