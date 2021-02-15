function [wavePCData,pc] = F_WavePCA(data,norm)
% MClust
% OUTPUTS
%    Data - nSpikes x nPC*nCh  of waveform PCs of each spike for each valid channel
%    Names - "wavePCn: Ch"
%    wavePCPar - 4x1 cell array struct of Parameters; fields same as Params input above

% CCC: PL
% version 1.0
%
% Status: PROMOTED (Release version)
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.0.
% Version control M3.0.

%%% PARAMETERS:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% norm = 1;    % normalize Waveforms (1) or don't normalize (0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nSpikes,nSamp] = size(data);
I = ones(nSpikes,1);

w = data;    % get data in nSpikes x nSamp array
if norm == 1
    % normalize waveforms to unit L2 norm (so that only their SHAPE or
    % relative angles but not their length (energy) matters)
    
%     l2norms = sqrt(sum(w.^2,2));
%     w = w./l2norms(:,ones(1,nSamp));
    
    maxvalue = max(w,[],2);
    minvalue  = min(w,[],2);
    w = (w - repmat(minvalue,[1,size(w,2)])) ./  (repmat(minvalue,[1,size(w,2)]) - repmat(maxvalue,[1,size(w,2)]));
    
    % ncst 3.5 modification - if you have a waveform of all zeros
    % (encountered in some Axona recordings on valid channels), you'll get
    % a NaN after normalization, which kills the princomp calculation.  So,
    % replace NaNs with zeros.
    w(isnan(w(:,1)),:) = 0;
end
cv = cov(w);
sd = sqrt(diag(cv))';        % row std vector
av = mean(w);                % row mean vector
pc = child_wavePCA(cv);      % get PCA eigenvectors (in columns of pc)

wstd=(w-(I*av))./(I*sd);     % standardize data to zero mean and unit variance
% wstd = w;
wpc = wstd*pc;               % project data onto principal component axes
wavePCData = wpc(:,1:3);
end


function [pc,rpc,ev,rev] = child_wavePCA(cv)
% [pc,rpc,ev,rev] = wavePCA(cv)
%
% Principal Component Analysis of standardized waveforms from a
% given (unstandardized) waveform covariance matrix cv(nSamp,nSamp).
%
% INPUT:
%      cv ... nSamp x nSamp wavefrom covariance matrix (unnormalized)
%
% OUTPUT:
%      pc ... column oriented principal components (Eigenvectors)
%      rpc ... column oriented Eigenvectors weighted with their relative amplitudes
%      ev ... eigenvalues of SVD (= std deviation of data projected onto pc)
%      rev ... relative eigenvalues so that their sum = 1
%
% PL 1999
%
% Status: PROMOTED (Release version)
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.0.
% Version control M3.0.

% sd = sqrt(diag(cv));
% cvn = cv./(sd*sd');    % standardized convariance matrix: diag=(1,1,1,...,1)
% [~,ev,pc] = svd(cvn);

[~,ev,pc] = svd(cv);
ev  = diag(ev);
% rev = ev/sum(ev);
rev = ev;
rpc = pc.*rev(:,ones(length(rev),1))';
end