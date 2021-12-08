%% create 100 random numbers between 0 and 1 and visualize them

%% Arduino sampling problem
% An arduino circuit is trying to sample the voltage at a power line in Europe. 
% It takes one sample every 2 to 10 ms (uniformly distributed) for 200 milliseconds. 
% Simulate this system by generating the timestamps and the values of the voltage in the power line.
% Plot the sampled signal as a function of time

%% NI-DAQ sampling
% A National Instruments DAQ system samples voltage from a North American
% outlet for 120 ms. Create signals when the sampling rate is set to (a) 72 Hz, (b) 120 Hz, (c) 600 Hz.


%% Image as a composition of signals
% Create a gabor image using your knowledge of sampling and frequency

%% Time vs frequency domain
% Extract the flicker from the mouse OFT video and determine its frequency

%% Nonlinear time domain filtering
% Extract the background image of the OFT (without the mouse)

%% Impulse response, convolution, and linear time-invariant systems
% simulate Ca2+ sensor response of a neuron with mean firing rate of 10 Hz

% Simulate Ca2+ sensor dynamics
tSim_kern = 500/1000; % 100 ms
dt = 1/1000;
tau = 100/1000; % s 
riseOrder = 4; % 'fall-off' dynamics
t = 0:dt:tSim_kern; % s
f = ((t/tau).*( exp(1-(t/tau)) )).^riseOrder;

% Simulate a spike train for a neuron firing at 10 Hz
fr = 10; % Hz
tSim_caSig = 120; % s
spikeTrain = rand(1, tSim_caSig/dt) < fr*dt;

figure;
caSig = conv(spikeTrain, f);
t = (0:length(caSig)-1)*dt;
plot(t, caSig);
hold all;
stem(find(spikeTrain == 1)*dt, spikeTrain((spikeTrain == 1)));