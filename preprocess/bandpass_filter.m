function y = bandpass_filter(x, fs, f_lo, f_hi)
% bandpass_filter  Simple bandpass filter for LFP-like signals.
%
% Usage:
%   y = bandpass_filter(x, fs, f_lo, f_hi)
%
% Inputs:
%   x    : [T x C] signal (time x channels) OR [T x 1]
%   fs   : sampling rate (Hz)
%   f_lo : low cutoff (Hz)
%   f_hi : high cutoff (Hz)
%
% Output:
%   y : filtered signal, same size as x
%
% Notes:
%   Uses a 4th-order Butterworth filter + filtfilt (zero-phase).
%   Keeps implementation intentionally simple for teaching/demo.

    arguments
        x double
        fs (1,1) double {mustBePositive}
        f_lo (1,1) double {mustBeNonnegative}
        f_hi (1,1) double {mustBePositive}
    end

    if f_lo >= f_hi
        error("bandpass_filter:InvalidCutoff", "f_lo must be < f_hi.");
    end

    % Normalize cutoffs to Nyquist
    wn = [f_lo, f_hi] / (fs / 4);
    wn(wn <= 0) = eps;
    wn(wn >= 1) = 1 - eps;

    [b, a] = butter(4, wn, "bandpass");

    % Apply along time dimension
    y = filtfilt(b, a, x);
end
