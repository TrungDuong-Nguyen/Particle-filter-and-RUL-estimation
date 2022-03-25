%% Initialize the particle filter

% Initial state
x = 0; 
% Set of Ns samples representing the degradation state
x_P = zeros(1,Ns); 
% Importance weights associated with Ns samples
P_w = zeros(1,Ns); 

% Simulate according to the initial distribution 
for i = 1:Ns
    x_P(i) = x + dev_init_sample*randn;
    P_w(i) = 1/Ns;
end