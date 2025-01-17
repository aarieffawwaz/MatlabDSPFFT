clc
clear
close

[audio, fs] = audioread('piano_C_major.wav');
x = audio(1:10000);
N = length(x);
t = (0:N-1) / fs;

subplot(2,1,1);
plot(t, x);
title('Time-Domain Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

X = zeros(1, N);
for k = 1:N
    for n = 1:N
        X(k) = X(k) + x(n) * exp(-1i * 2 * pi * (k-1) * (n-1) / N);
    end
end

f_manual = (0:(N-1)/2) * fs / N;

subplot(2,1,2);
plot(f_manual, abs(X(1:N/2)));
hold on;

[~, index_manual] = max(abs(X(1:N/2)));
fundamental_freq_manual = f_manual(index_manual);
plot(fundamental_freq_manual, abs(X(index_manual)), 'ro', 'MarkerSize', 8);
hold off;

title('Frequency Domain - Manual FFT (One Cycle)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

fprintf('Fundamental Frequency: %.2f Hz\n', fundamental_freq_manual);