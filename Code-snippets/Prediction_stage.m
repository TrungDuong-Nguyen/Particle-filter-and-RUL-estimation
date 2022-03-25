T = 500; % Time length

% At each instant (t), do:
for t = 1:T
    %% Initialize the particle filter
    % ...
    %% The body of the particle filter

    % Each of Ns particles involves independently
    for i = 1:Ns
        % Prediction stage
        % Mutate the sample according to transition kernel
        x_P_update(i) = x_P(i) + gamrnd (a,b);
        
        % Correction and Estimation stage
        % ...
    end
% ...
end