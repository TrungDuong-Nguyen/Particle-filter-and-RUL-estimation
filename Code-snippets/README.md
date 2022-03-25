The following notes resumes what has been presented in sub-section 3.3 - _Implémentation Matlab_ of the [French report](/Report/Rapport-de-stage.pdf). Through the code snippets, I present four steps of implementing the SIS particle filter for our problem, and give on the way some interpretations/ explanations.

## Create the measurement values _(Yt)_ (i.e., the monitoring data)
Firstly, we generate a sequence of random variables _(xt)_ that represents the real degradation level, using the transition kernel. Then, at each instant _(t)_, _(xt)_ is added up a Gaussian noise to give the corresponding measurement value (_Yt_). In practice, the particle filter will re-estimate, based on these measurement values, the hidden state _(xt)_.  

```matlab
%% Create the monitoring data

T = 500; % Time length

% At each instant (t), do 
for t = 1:T
    % Update the cumulated degradation level
    x = x + gamrnd(a,b);
    % Create the corresponding measurement value
    y = x + dev_noise*randn;
end
```

Note that:
- `gamrnd(a,b)` generates a random variable from the distribution _Γ(k, θ)_.
- `dev_noise` represents the standard deviation _(σ)_ of the measurement noise.
- `dev_noise*randn` generates a random variable from the distribution _Ν(0, σ²)_.

## Initialisation stage
Suppose that at the beginning, the system is new (_x₀ = 0_) and we don't perform any observation, thus (_y₀_) doesn't exist. Also, suppose that the initial distribution is Normal distribution: _p(x₀) = Ν(0, σ₀²)_.

```matlab
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
```

Note that:
- `dev_init_sample` represents the standard deviation _(σ₀)_ of the initial distribution.
- `dev_init_sample*randn` generates a random variable from the distribution _Ν(0, σ²)_

We dispose now a set of _(Ns)_ _particles_ that represents the initial degradation state of the system. These particles characterizes the _a priori_ law under the viewpoint of Bayesian estimation. When receiving the first measurement value _(y₁)_, the particle filter gets going. The essence of the filter is constituted of two stages that generate the samples according to the importance law, then weight these samples (i.e., update their associated weights) to form a new set of (_samples_, _weights_) which approximate the _a posteriori_ law _p(x₁|y₁)_.

## Prediction stage
Since the transition kernel is chosen as the importance law, the first stage, prediction (sampling) consists of mutate the samples using this kernel. After this stage, we obtain a new set of independent samples.

```matlab
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
```

## Correction and estimation stage
When the first measurement value _(y₁)_ is available, we evaluate the likelihood of each sample and compute its corresponding weight. In fact, the weight quantifies the adequacy of each sample vis-à-vis the current observation. The sample that offers a value (this value is got thanks to the observation equation of the model) closer to _(y₁)_ will be assigned a more significant weight. Notice that in order to compute the weight, we must, at first, determine the likelihood function _p(y₁|x₁)_. Finally, we perform the normalization of the weights to obtain a set of particles (_samples_, _weights_), then estimate the degradation level by doing the weighted sum of all the sample values.

```matlab
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
```

The command line `y_update(i) = x_P_update(i)` refers to the observation equation `y = x + ε` of the model. For our problem, fortunately, this equation is simple. But for other cases, for example, with other measurement techniques, it may be non-linear. Therefore, instead of using directly `x_P_update(i)` in the computation of the importance weights, we add the above-mentionned command to match the general case the algorithm SIS particle filter. At the end of the cycle, the samples are propagated to next instant _(t=2)_ to characterize the _a priori_ law _p(x₂|y₁)_.