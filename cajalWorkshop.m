fdir = 'C:\Users\Praneeth\Desktop\Cajal2021\workshop\';
fname = 'mouse_OFT.mp4';
v = VideoReader([fdir fname]);

%% import a small segment of a video
vid = zeros(v.Height, v.Width, v.NumFrames);
v.CurrentTime = 0;
frameCount = 0;
while hasFrame(v)
    frameCount = frameCount + 1;
    vid(:,  :, frameCount) = rgb2gray(readFrame(v));
end
vid_frames = (1:v.NumFrames)';


%% plot the value of one pixel and how it is changing in time
figure;
subplot(2, 1, 1);
plot(vid_frames, squeeze(vid(10, 20, :)));
subplot(2, 1, 2);
plot(vid_frames, squeeze(vid(10, 20, :)), LineStyle="none", Marker="o");
xlabel('Sample (frame) number');
ylabel('Sample value');
linkaxes;

%% Discuss - Sampling, digitization

%% Assigning meaningful units to sample number and sample value
vid_t = (vid_frames-1)/v.FrameRate;
figure;
subplot(2, 1, 1);
plot(vid_t, squeeze(vid(10, 20, :)));
xlabel('Time (s)');
ylabel('Intensity (a.u.)');
subplot(2, 1, 2);
plot(vid_t, squeeze(vid(10, 20, :)), LineStyle="none", Marker="o");
linkaxes;

%% Discuss
% Uniform sampling - Using an Arduino vs NIDAQ
% Time management - Clocks and synchronization


%% show the first frame
f = figure;
hIm = imagesc(vid(:, :, 1));
colormap gray;
axis equal;
axis off;
impixelinfo;
set(f,'WindowButtonDownFcn', @mytestcallback);

%% video as a collection of signals
figure;
plot(squeeze(vid(10, 20, :)));

%% compute the median image
im_bkg = zeros(size(vid,1), size(vid, 2));
for i = 1:size(vid, 1)
    for j = 1:size(vid, 2)
        im_bkg(i, j) = median(squeeze(vid(i, j, :)));
    end
end

%% visualize the background image
figure; 
imagesc(im_bkg); 
colormap gray;
axis equal;
axis off;
