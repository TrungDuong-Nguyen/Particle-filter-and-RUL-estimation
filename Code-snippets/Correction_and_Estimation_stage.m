T = 500; % Time length

% At each instant (t), do:
for t = 1:T
    %% Initialize the particle filter
    % ...
    %% The body of the particle filter
    
    % Each of Ns particles involves independently
    for i = 1:Ns
        % Prediction stage
        % ...
        
        % Correction and Estimation stage
        y_update(i) = x_P_update(i);
        P_w(i) = P_w(i)*(1/(dev_noise*sqrt(2*pi)))*exp(-(y_update(i)-y)^2/(2*dev_noise^2));
    end
    
    % Normalize the importance weights
    P_w = P_w./sum(P_w);
    
    % Estimate the degradation level
    for i = 1:Ns
        x_estimate = x_estimate + P_w(i)*x_P_update(i);
    end
    
    % Propagate the samples to next instant (t)
    x_P = x_P_update;
end