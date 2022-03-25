%% Create the monitoring data

T = 500; % Time length

% At each instant (t), do 
for t = 1:T
    % Update the cumulated degradation level
    x = x + gamrnd(a,b);
    % Create the corresponding measurement value
    y = x + dev_noise*randn;
end