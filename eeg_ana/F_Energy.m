function energyData = F_Energy(data)

% MClust
% Calculate energy feature max value for each channel. Normalizes for #
% samples in waveform.
%
% ADR April 1998
% JCJ Nov 2003 Modified to use cubic spline


[~,nSamp] = size(data);

energyData = squeeze(sqrt(sum(data.^2,2)))./sqrt(nSamp);


