%% create 100 random numbers between 0 and 1 and visualize them
figure;
x = rand(100, 1);
plot(x);
hold all;
scatter(1:length(x), x);
%% Arduino sampling problem
% An arduino circuit is trying to sample the voltage at a power line in Europe. 
% It takes one sample every 2 to 10 ms (uniformly distributed) for 200 milliseconds. 
% Simulate this system by generating the timestamps and the values of the voltage in the power line.
% Plot the sampled signal as a function of time

%% NI-DAQ sampling
% A National Instruments DAQ system samples voltage from a North American
% outlet for 120 ms. Create signals when the sampling rate is set to (a) 72 Hz, (b) 120 Hz, (c) 600 Hz.
f_sig = 60; %
t_sample = 0.12;
f_sampler = 600;
n_samples = f_sampler*t_sample;

sample_arr = 1:n_samples;
t = (sample_arr-1)/f_sampler;

sig = 110*sin(2*pi*f_sig*t);

figure;
plot(t*1000, sig);
xlabel('Time (ms)');

f_sampler = 120;
n_samples = f_sampler*t_sample;

sample_arr = 1:n_samples;
t = (sample_arr-1)/f_sampler;

sig = 110*sin(2*pi*f_sig*t + pi/2);
hold all;
plot(t*1000, sig);

%% Image as a composition of signals
% Create a gabor image using your knowledge of sampling and frequency

%% Time vs frequency domain
% Extract the flicker from the mouse OFT video and determine its frequency
% Then, filter this signal

avg_intensity = squeeze(mean(mean(vid, 1), 2));

% figure;
% plot(avg_intensity);

% [fftAmp, f] = my_fftAmp(avg_intensity, 30);
% figure;
% plot(f(2:end), fftAmp(2:length(f)));

figure;
plot(hdl.vid_t, avg_intensity);
hold all;
plot(hdl.vid_t, my_fftFilt(avg_intensity, 30, [9 11]));

%% Nonlinear time domain filtering
% Extract the background image of the OFT (without the mouse)


bk_img = zeros(size(vid, 1), size(vid, 2));
for i = 1:size(vid, 1)
    for j = 1:size(vid, 2)
        bk_img(i, j) = median(squeeze(vid(i, j, :)));
    end
end

%%
figure;
imagesc(bk_img);
axis off;
axis equal;
colormap gray;

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