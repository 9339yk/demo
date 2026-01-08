function results = analysis_template()
% analysis_template  Starter template for personal analysis scripts.
%
% Copy this file into your own folder under analysis/<name>/.
% Keep preprocess shared in preprocess/ and avoid editing it casually.

    % ---- Load or generate demo data ----
    [raw, fs, labels] = local_load_or_generate();

    % ---- Shared preprocessing ----
    pp = preprocess_lfp(raw, fs);

    % ---- Feature extraction (simple example) ----
    feats = local_features(pp.zscored, fs);

    % ---- Simple analysis: difference between classes ----
    m0 = mean(feats(labels==0,:), 1);
    m1 = mean(feats(labels==1,:), 1);

    results = struct();
    results.mean_class0 = m0;
    results.mean_class1 = m1;

    disp("Template results:");
    disp(results);

end

function feats = local_features(x, fs)
% x: [T x C]
% Return features per trial-like chunks (toy example)

    win_s = 0.5;                 % seconds
    hop_s = 0.5;
    win = max(1, round(win_s * fs));
    hop = max(1, round(hop_s * fs));

    T = size(x,1);
    C = size(x,2);
    n = floor((T - win) / hop) + 1;

    feats = zeros(n, C);
    for i = 1:n
        idx = (1:win) + (i-1)*hop;
        seg = x(idx, :);
        feats(i,:) = rms(seg, 1); % RMS per channel
    end
end

function [raw, fs, labels] = local_load_or_generate()
    fs = 500; % Hz

    dataPath = fullfile("data", "sample_lfp.mat");
    if exist(dataPath, "file")
        S = load(dataPath);
        raw = S.raw;
        labels = S.labels;
        if isfield(S, "fs"); fs = S.fs; end
        return;
    end

    % Generate synthetic 2-class LFP-like data for demo
    rng(7);
    T = fs * 20;     % 20 sec
    C = 4;           % 4 channels
    t = (0:T-1)'/fs;

    base = 0.3 * randn(T, C);
    osc1 = sin(2*pi*10*t);       % 10 Hz component
    osc2 = sin(2*pi*20*t);       % 20 Hz component

    raw = base;
    raw(:,1) = raw(:,1) + 0.6*osc1;
    raw(:,2) = raw(:,2) + 0.4*osc1;
    raw(:,3) = raw(:,3) + 0.2*osc2;
    raw(:,4) = raw(:,4) + 0.1*osc2;

    % Create toy labels per chunk (0/1 alternating)
    nChunks = floor(T/(fs*0.5));
    labels = repmat([0;1], ceil(nChunks/2), 1);
    labels = labels(1:nChunks);

    % Note: we do NOT save into data/ automatically, because it's gitignored.
end
