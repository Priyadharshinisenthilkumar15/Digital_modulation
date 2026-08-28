%1.FM modulation and demodulation of a sinusoidal message signalusing the in-built fmmod and fmdemod functions.

Am = 1;
fm = 10;
fc = 100;
fs = 5000;
kf = 50;
t = 0:1/fs:0.5;

m = Am*cos(2*pi*fm*t);

FM = fmmod(m,fc,fm,kf);
DEMFM = fmdemod(FM, fc, fm, kf);

subplot(3,1,1);
plot(t, m);
sgtitle('PRIYADHARSHINI.S EC23I1010')
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, FM);
title('FM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, DEMFM);
title('FM Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
