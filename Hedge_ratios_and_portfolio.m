% Step 8.1: Prepare inputs from the stochastic volatility model
% Assume 'log_returns' contains the stationary return series for Crude_Oil and MSCI

% Select two assets for hedge ratio calculation
asset_1 = 'Crude_Oil';
asset_2 = 'MSCI';

% Extract posterior volatilities and covariances (simulated data here)
time_steps = length(log_returns);
rng(42);  % Set random seed for reproducibility

% Simulate volatilities and covariances for simplicity
vol_1 = exp(normrnd(0.1, 0.02, [time_steps, 1]));  % Volatility for Crude Oil
vol_2 = exp(normrnd(0.2, 0.03, [time_steps, 1]));  % Volatility for MSCI
covariance = normrnd(0.01, 0.005, [time_steps, 1]);  % Covariance between Crude Oil and MSCI

% Calculate dynamic hedge ratios
hedge_ratios = covariance ./ vol_2.^2;

% Step 8.2: Visualize hedge ratios
figure('Position', [100, 100, 800, 600]);
plot(log_returns.Date, hedge_ratios, 'b-', 'LineWidth', 2);
hold on;
yline(0, 'r--', 'Zero Hedge Line');
title('Figure 12: Dynamic Hedge Ratios');
xlabel('Date');
ylabel('Hedge Ratio');
legend(['Hedge Ratio (' asset_1 ' vs ' asset_2 ')'], 'Location', 'best');
grid on;
hold off;

% Step 8.3: Portfolio Risk Evaluation (Optional)
% Calculate hedged portfolio returns
hedged_returns = log_returns.(asset_1) - hedge_ratios .* log_returns.(asset_2);

% Plot hedged vs unhedged portfolio returns
figure('Position', [100, 100, 800, 600]);
plot(log_returns.Date, log_returns.(asset_1), 'Color', [1, 0.647, 0], 'LineWidth', 1.5, 'DisplayName', ['Unhedged ' asset_1 ' Returns']);
hold on;
plot(log_returns.Date, hedged_returns, 'g-', 'LineWidth', 1.5, 'DisplayName', ['Hedged ' asset_1 ' Returns']);
title(['Hedged vs Unhedged Returns for ' asset_1]);
xlabel('Date');
ylabel('Returns');
legend('show');
grid on;
hold off;

% Step 1: Prepare inputs
% Assume 'log_returns' contains the stationary return series
% For simulation, assume 'Food_price' is the average of 'Maize' and 'Barley' returns

log_returns.Food_price = mean(log_returns{:, {'Maize', 'Barley'}}, 2);

% Assets for analysis
pairs = {'MSCI', 'Food_price'; 'Crude_Oil', 'Food_price'};

% Simulated conditional volatilities and covariances (replace with real model output)
time_steps = height(log_returns);  % Number of time steps
rng(42);  % Set random seed for reproducibility

% Simulate volatilities for MSCI, Crude_Oil, and Food_Price
simulated_vols.MSCI = exp(normrnd(0.2, 0.03, [time_steps, 1]));  % MSCI volatility
simulated_vols.Crude_Oil = exp(normrnd(0.15, 0.02, [time_steps, 1]));  % Crude_Oil volatility
simulated_vols.Food_price = exp(normrnd(0.1, 0.02, [time_steps, 1]));  % Food_price volatility

% Simulate covariances between the assets
simulated_covariances.MSCI_Food_price = normrnd(0.02, 0.005, [time_steps, 1]);  % MSCI and Food_price covariance
simulated_covariances.Crude_Oil_Food_price = normrnd(0.015, 0.004, [time_steps, 1]);  % Crude_Oil and Food_price covariance

% Step 2: Calculate hedge ratios
hedge_ratios = struct();  % Initialize the structure to store hedge ratios
for i = 1:size(pairs, 1)
    hedging_asset = pairs{i, 1};
    target_asset = pairs{i, 2};
    
    % Extract covariance and volatility for the asset pair
    covariance = simulated_covariances.([hedging_asset, '_', target_asset]);
    variance_hedging = simulated_vols.(hedging_asset).^2;
    
    % Calculate hedge ratio
    hedge_ratios.(sprintf('%s_%s', hedging_asset, target_asset)) = covariance ./ variance_hedging;
end
% Step 3: Plot dynamic hedge ratios
pairs = {'MSCI', 'Food_price'; 'Crude_Oil', 'Food_price'};  % Asset pairs
time_steps = height(log_returns);  % Number of time steps

for i = 1:size(pairs, 1)
    hedging_asset = pairs{i, 1};
    target_asset = pairs{i, 2};
    
    % Extract the hedge ratio for the current pair
    hedge_ratio = hedge_ratios.(sprintf('%s_%s', hedging_asset, target_asset));
    
    % Plot dynamic hedge ratios
    figure('Position', [100, 100, 800, 600]);
    plot(log_returns.Date, hedge_ratio, 'b', 'DisplayName', sprintf('Hedge Ratio (%s vs %s)', target_asset, hedging_asset));
    hold on;
    yline(0, 'r--', 'Zero Hedge Line');  % Zero hedge line
    title(sprintf('Dynamic Hedge Ratios: %s vs %s', target_asset, hedging_asset));
    xlabel('Date');
    ylabel('Hedge Ratio');
    legend('show');
    grid on;
    hold off;
    tight_layout;
end

% Step 4: Portfolio Risk Evaluation (Optional)
for i = 1:size(pairs, 1)
    hedging_asset = pairs{i, 1};
    target_asset = pairs{i, 2};
    
    % Calculate hedged returns
    hedge_ratio = hedge_ratios.(sprintf('%s_%s', hedging_asset, target_asset));
    hedged_returns = log_returns{:, target_asset} - hedge_ratio .* log_returns{:, hedging_asset};
    
    % Plot hedged vs unhedged portfolio returns
    figure('Position', [100, 100, 800, 600]);
    plot(log_returns.Date, log_returns{:, target_asset}, 'orange', 'LineWidth', 1.5, 'DisplayName', sprintf('Unhedged %s Returns', target_asset));
    hold on;
    plot(log_returns.Date, hedged_returns, 'g', 'LineWidth', 1.5, 'DisplayName', sprintf('Hedged %s Returns', target_asset));
    title(sprintf('Hedged vs Unhedged Returns: %s using %s', target_asset, hedging_asset));
    xlabel('Date');
    ylabel('Returns');
    legend('show');
    grid on;
    hold off;
    tight_layout;
end
