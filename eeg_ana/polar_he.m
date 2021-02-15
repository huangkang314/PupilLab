function hpol = polar_he(varargin)
%POLAR  Polar coordinate plot.
%   POLAR(THETA, RHO) makes a plot using polar coordinates of
%   the angle THETA, in radians, versus the radius RHO.
%   POLAR(THETA, RHO, S) uses the linestyle specified in string S.
%   See PLOT for a description of legal linestyles.
%
%   POLAR(AX, ...) plots into AX instead of GCA.
%
%   H = POLAR(...) returns a handle to the plotted object in H.
%
%   Example:
%      t = 0 : .01 : 2 * pi;
%      polar(t, sin(2 * t) .* cos(2 * t), '--r');
%
%   See also PLOT, LOGLOG, SEMILOGX, SEMILOGY.

%   Copyright 1984-2010 The MathWorks, Inc.
%   $Revision: 5.22.4.10 $  $Date: 2010/05/20 02:25:28 $

% Parse possible Axes input
[cax, args] = axescheck(varargin{:});

[theta, rho, linecolor, line_style,lim] = deal(args{1:5});

if ~isequal(size(theta), size(rho))
    error('MATLAB:polar:InvalidInput', 'THETA and RHO must be the same size.');
end

% get hold state
cax = newplot(cax);

next = lower(get(cax, 'NextPlot'));
hold_state = ishold(cax);

% get x-axis text color so grid is in same color
tc = get(cax, 'XColor');
ls = get(cax, 'GridLineStyle');

% Hold on to current Text defaults, reset them to the
% Axes' font attributes so tick marks use them.
fAngle = get(cax, 'DefaultTextFontAngle');
fName = get(cax, 'DefaultTextFontName');
fSize = get(cax, 'DefaultTextFontSize');
fWeight = get(cax, 'DefaultTextFontWeight');
fUnits = get(cax, 'DefaultTextUnits');
set(cax, ...
    'DefaultTextFontAngle', get(cax, 'FontAngle'), ...
    'DefaultTextFontName', get(cax, 'FontName'), ...
    'DefaultTextFontSize', get(cax, 'FontSize'), ...
    'DefaultTextFontWeight', get(cax, 'FontWeight'), ...
    'DefaultTextUnits', 'data');

% only do grids if hold is off
if ~hold_state
    
    % make a radial grid
    hold(cax, 'on');
    % ensure that Inf values don't enter into the limit calculation.
    hhh = line([-lim(1), -lim(1), lim(1), lim(1)], [-lim(1), lim(1), lim(1), -lim(1)], 'Parent', cax);
    
    set(cax, 'DataAspectRatio', [1, 1, 1], 'PlotBoxAspectRatioMode', 'auto');
    v = [get(cax, 'XLim') get(cax, 'YLim')];
    ticks = sum(get(cax, 'YTick') >= 0);
    delete(hhh);
    % check radial limits and ticks
    rmin = 0;
    rmax = v(4);
    rticks = max(ticks - 1, 2);
    if rticks > 5   % see if we can reduce the number
        if rem(rticks, 2) == 0
            rticks = rticks / 2;
        elseif rem(rticks, 3) == 0
            rticks = rticks / 3;
        end
    end
    
    % define a circle
    th = 0 : pi / 100 : 2 * pi;
    xunit = cos(th);
    yunit = sin(th);
    % now really force points on x/y axes to lie on them exactly
    inds = 1 : (length(th) - 1) / 4 : length(th);
    xunit(inds(2 : 2 : 4)) = zeros(2, 1);
    yunit(inds(1 : 2 : 5)) = zeros(3, 1);
    % plot background if necessary
    if ~ischar(get(cax, 'Color'))
        patch('XData', xunit * lim(1), 'YData', yunit * lim(1), ...
            'EdgeColor', tc, 'FaceColor', get(cax, 'Color'), ...
            'HandleVisibility', 'off', 'Parent', cax,'linewidth',2);
    end
    
    % draw radial circles
    c82 = cos(82 * pi / 180);
    s82 = sin(82 * pi / 180);
    rinc = (rmax - rmin) / rticks;
    
    hhh = line(xunit * lim(2), yunit * lim(2), 'LineStyle', '-', 'Color', [0 0 0], 'LineWidth', 2, ...
        'HandleVisibility', 'off', 'Parent', cax);
    text((lim(2) + rinc / 20 +.1 ) * c82, (lim(2) + rinc / 20) * s82, ...
        ['  ' num2str(lim(2))], 'VerticalAlignment', 'bottom', ...
        'HandleVisibility', 'off', 'Parent', cax,'Fontsize',20);
    
    text((lim(1) + rinc/20 +.15) * c82, (lim(1) + rinc/20 ) * s82, ...
        ['  ' num2str(lim(1))], 'VerticalAlignment', 'bottom', ...
        'HandleVisibility', 'off', 'Parent', cax,'Fontsize',20);
    
    
    th = (0 : 3) * 2 * pi/4;
    cst = cos(th);
    snt = sin(th);
    
    
    % annotate spokes in degrees
    rt = 1.15 * rmax;
    for i = 1 : length(th)
        text(rt * cst(i), rt * snt(i), [int2str((i-1) * 90),'^o'],...
            'HorizontalAlignment', 'center', ...
            'HandleVisibility', 'off', 'Parent', cax,'Fontsize',20);
    end
    
    % set view to 2-D
    view(cax, 2);
    % set axis limits
    axis(cax, rmax * [-1.15, 1.15, -1.15, 1.15]);
end

% Reset defaults.
set(cax, ...
    'DefaultTextFontAngle', fAngle , ...
    'DefaultTextFontName', fName , ...
    'DefaultTextFontSize', fSize, ...
    'DefaultTextFontWeight', fWeight, ...
    'DefaultTextUnits', fUnits );

% transform data to Cartesian coordinates.
xx = rho .* cos(theta);
yy = rho .* sin(theta);

% plot data on top of grid
if strcmp(line_style, 'auto')
    q = plot(xx, yy, 'Parent', cax);
else
    q = plot(xx, yy, line_style, 'Parent', cax,'color',linecolor,'linewidth',2);
end

set(gcf,'color',[1 1 1])
if nargout == 1
    hpol = q;
end

if ~hold_state
    set(cax, 'DataAspectRatio', [1, 1, 1]), axis(cax, 'off');
    set(cax, 'NextPlot', next);
end
set(get(cax, 'XLabel'), 'Visible', 'on');
set(get(cax, 'YLabel'), 'Visible', 'on');

if ~isempty(q) && ~isdeployed
    makemcode('RegisterHandle', cax, 'IgnoreHandle', q, 'FunctionName', 'polar');
end
end
