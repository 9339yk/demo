function plot_helper(t, x, ttl)
% plot_helper  Minimal plotting helper for demo.
%
% Usage:
%   plot_helper(t, x, "Title")
%
% Inputs:
%   t   : time vector [T x 1]
%   x   : signal [T x 1] or [T x C]
%   ttl : title string

    arguments
        t double
        x double
        ttl string = ""
    end

    figure("Name", char(ttl));
    plot(t, x, "LineWidth", 1);
    xlabel("Time (s)");
    ylabel("Amplitude (a.u.)");
    title(ttl);
    grid on;
end
