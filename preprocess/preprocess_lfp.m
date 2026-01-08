function out = preprocess_lfp(raw, fs)
% preprocess_lfp  Common preprocessing for LFP signals (shared by lab).
%
% This is intended to be the "stable" pipeline that everyone trusts.
% Keep it simple and well-documented.
%
% Usage:
%   out = preprocess_lfp(raw, fs)
%
% Inputs:
%   raw : [T x C] raw LFP (time x channels)
%   fs  : sampling rate (Hz)
%
% Output (struct):
%   out.fs
%   out.raw
%   out.filtered
%   out.zscored
%   out.params

    arguments
        raw double
        fs (1,1) double {mustBePositive}
    end

    params = struct();
    params.band = [1, 40];     % Hz (classic LFP-ish band for demo)
    params.detrend = true;
    params.zscore = true;

    x = raw;

    if params.detrend
        x = detrend(x); % remove slow drift
    end

    x_f = bandpass_filter(x, fs, params.band(1), params.band(2));

    if params.zscore
        mu = mean(x_f, 1, "omitnan");
        sd = std(x_f, 0, 1, "omitnan");
        sd(sd == 0) = 1;
        x_z = (x_f - mu) ./ sd;
    else
        x_z = x_f;
    end

    out = struct();
    out.fs = fs;
    out.raw = raw;
    out.filtered = x_f;
    out.zscored = x_z;
    out.params = params;
end
