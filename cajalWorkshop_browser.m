fdir = [pwd, '\'];
fname = 'mouse_OFT.mp4';
v = VideoReader([fdir fname]);

global hdl;

hdl.vid = zeros(v.Height, v.Width, v.NumFrames);
v.CurrentTime = 0;
frameCount = 0;
while hasFrame(v)
    frameCount = frameCount + 1;
    hdl.vid(:,  :, frameCount) = rgb2gray(readFrame(v));
end
hdl.vid_frames = (1:v.NumFrames)';
hdl.vid_t = (hdl.vid_frames-1)/v.FrameRate;
hdl.current_frame = 1;
hdl.current_point = [10, 20];
hdl.baseline_img = zeros(size(hdl.vid, 1), size(hdl.vid, 2));
for i = 1:size(hdl.vid, 1)
    for j = 1:size(hdl.vid, 2)
        hdl.baseline_img(i, j) = median(squeeze(hdl.vid(i, j, :)));
    end
end

%%
hdl.f = figure('Units','normalized','OuterPosition',[0, 0, 1, 0.7]);
hdl.axIm = subplot(1, 3, 1);
hdl.hIm = imagesc(hdl.vid(:, :, hdl.current_frame));
colormap gray;
axis equal;
axis off;
impixelinfo;
hold all;
hdl.sc = scatter(10, 20);
hdl.axPl = subplot(1, 3, [2 3]);
hdl.pl = plot(hdl.vid_t, squeeze(hdl.vid(10, 20, :)));
ylim([0 255]);
hold all;
hdl.pl_time = plot(hdl.vid_t(hdl.current_frame)*[1 1], get(hdl.axPl, 'YLim'), 'k', 'LineWidth', 2);
set(hdl.f,'WindowButtonDownFcn', @imclick);
set(hdl.f,'KeyPressFcn', @keypress);
update_plots();

function [] = imclick(~,~)
global hdl;
pt = get(hdl.axIm,'CurrentPoint');
X = round(pt(1, 1));
Y = round(pt(1, 2));
if X >= 1 && X <= size(hdl.vid, 2) && Y >= 1 && Y <= size(hdl.vid, 1)
    hdl.current_point = [X, Y];
end
update_plots();
end


function [] = keypress(~, ev)
global hdl;
switch ev.Key
    case 'rightarrow'
        hdl.current_frame = min(hdl.current_frame+1, size(hdl.vid, 3));
    case 'leftarrow'
        hdl.current_frame = max(hdl.current_frame-1, 1);
    case 'uparrow'
        hdl.current_frame = min(hdl.current_frame+30, size(hdl.vid, 3));
    case 'downarrow'
        hdl.current_frame = max(hdl.current_frame-30, 1);
end
update_plots();
end

function [] = update_plots()
global hdl;

hdl.sc.XData = hdl.current_point(1);
hdl.sc.YData = hdl.current_point(2);
hdl.pl.YData = squeeze(hdl.vid(hdl.current_point(2), hdl.current_point(1), :));
hdl.pl_time.XData = hdl.vid_t(hdl.current_frame)*[1 1];

hdl.hIm.CData = hdl.vid(:, :, hdl.current_frame);
hdl.axIm.Title.String = ['Frame=' num2str(hdl.current_frame), ' Time=', num2str(hdl.vid_t(hdl.current_frame), '%.2f'), ' s'];
end