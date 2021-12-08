%fft for n points
%fftAmp is the amplitude of signal in fourier domain--- n*amplitude ---
%f represents the frequencies at which signal power is known

function [fftAmp, f] = my_fftAmp(signal, samplingRate, dim, n)

if ~exist('dim', 'var')
    dim = find(size(signal) == max(size(signal)));
end

if ~exist('n', 'var')
    n = size(signal, dim);
end

midPoint = ceil((n+1)/2);
fftSignal = fft(signal, n, dim);

fftAmp = abs(fftSignal)/n;
f = (samplingRate*(0:(midPoint-1))/n)';

% use fftAmp/n??