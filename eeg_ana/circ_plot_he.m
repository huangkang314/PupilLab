function circ_plot_he(alpha, varargin)
%
% r = circ_plot(alpha, ...)
%   Plotting routines for circular data.
%
%   Input:
%     alpha     sample of angles in radians
%     [format		specifies style of plot
%                 histogram, density, []
%     [formats  standard matlab string for plot format (like '.r')]

%         hist:     fourth argument determines number of bins/bin centers
%                   fifth argument determines whether normalized or count
%                     histogram is shown
%                   sixth argument toggles between showing mean direction
%                     and not showing it
%
%       All of these arguments can be left empty, i.e. set to [], so that
%       the default value will be used. If additional arguments are
%       supplied in the name-value style ('linewidth', 2, ...), these are
%       used to change the properties of the mean resultant vector plot.
%
%   Output:
%     a         axis handle
%
%   Examples:
%     alpha = randn(60,1)*.4+pi/2;
%     figure
%     circ_plot(alpha,'hist',[],20,true,true,'linewidth',2,'color','r')
%     title('hist plot style')
%     circ_plot(alpha,[],'s')
%     title('non-fancy plot style')
%
%
% Circular Statistics Toolbox for Matlab

% By Philipp Berens & Marc J. Velasco, 2009
% velasco@ccs.fau.edu, berens@tuebingen.mpg.de

% plot in  'hist style'
% this is essentially a wrapper for the rose plot function of matlab
% adds optionally the mean resultant vector

if nargin > 3 && ~isempty(varargin{1})
    x = varargin{1};
else
    x = 20;
end

[t,r] = rose(alpha,x);
polar_he(t,2*r/sum(r),varargin{6},'-',varargin{7})
mr = max(2*r/sum(r));

% plot mean directions with an overlaid arrow if desired
s = varargin{2};

op_setfigpar(gca)

if s
    r = circ_r(alpha) * mr;
    phi = circ_mean(alpha);
    hold on;
    zm = r*exp(1i*phi);
    plot([0 real(zm)], [0, imag(zm)],'color','b','linewidth',2)
    hold off;
end


