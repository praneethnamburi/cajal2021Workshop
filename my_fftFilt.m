%fft for n points
%fftAmp is the amplitude of signal in fourier domain--- n*amplitude_square/2 ---
%f represents the frequencies at which signal power is known

function [filtSig] = my_fftFilt(signal, samplingRate, filtArr, dim)
% filter has frequency ranges to be removed (number of filters x 2)
% to remove mean, supply [0 0]

if ~exist('dim', 'var')
    dim = find(size(signal) == max(size(signal)));
end

n = size(signal, dim);
midPoint = ceil((n+1)/2);
fftSignal = fft(signal, [], dim);

f = samplingRate*(0:(midPoint-1))/n;

if 2*length(f)-1 == n
    fAll = [f fliplr(f(2:end))];
elseif 2*length(f)-2 == n
    fAll = [f fliplr(f(2:end-1))];
end

filtArr(filtArr == -1) = unique(max(f));

fPoints = [];
for filtCount = 1:size(filtArr, 1)
    fPoints = union(fPoints, intersect(find(fAll >= filtArr(filtCount, 1)), find(fAll <= filtArr(filtCount, 2))));
end

fftSigTemp = permute(fftSignal, [dim, setdiff(1:ndims(fftSignal), dim)]);
fftSigTemp(fPoints, :) = 0;
fftSigFilt = ipermute(fftSigTemp, [dim, setdiff(1:ndims(fftSignal), dim)]);

filtSig = ifft(fftSigFilt, [], dim);