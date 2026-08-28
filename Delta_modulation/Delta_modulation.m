%Implement delta modulation on a sinusoidal message signal 

Am = 1;
fm = 2;
fs = 50;
t = 0:1/fs:2;

m = Am*sin(2*pi*fm*t);
delta_optimal = 2*pi*fm*Am/fs;

dm = zeros(size(m));     
mq = zeros(size(m));     

for n = 2:length(m)
    if m(n) >= mq(n-1)
        dm(n) = 1;
        mq(n) = mq(n-1) + delta_optimal;
    else
        dm(n) = 0;
        mq(n) = mq(n-1) - delta_optimal;
    end
end

md = zeros(size(dm));   
for n = 2:length(dm)
    if dm(n) == 1
        md(n) = md(n-1) + delta_optimal;
    else
        md(n) = md(n-1) - delta_optimal;
    end
end

figure;
sgtitle('Priyadharshini.S EC23I1010');
subplot(4,1,1);
plot(t,m,'LineWidth',1.5);
title('Message Signal');
xlabel('Time'); ylabel('Amplitude'); grid on;

subplot(4,1,2);
stairs(t,mq,'LineWidth',1.5);
title('Quantized (Staircase) Signal');
xlabel('Time'); ylabel('Amplitude'); grid on;

subplot(4,1,3);
stairs(t,dm,'LineWidth',1.5);
title('Encoded Delta Modulated Signal');
xlabel('Time'); ylabel('Bits'); grid on;

subplot(4,1,4);
plot(t,md,'LineWidth',1.5);
title('Decoded Signal');
xlabel('Time'); ylabel('Amplitude'); grid on;


N = length(m);
f = (-N/2:N/2-1)*(fs/N);

M_f  = abs(fftshift(fft(m)));
MQ_f = abs(fftshift(fft(mq)));
MD_f = abs(fftshift(fft(md)));

figure;
sgtitle('Priyadharshini.S EC23I1010');
subplot(3,1,1);
plot(f,M_f);
title('Spectrum of Message Signal');
xlabel('Frequency (Hz)'); ylabel('|M(f)|'); grid on;

subplot(3,1,2);
plot(f,MQ_f);
title('Spectrum of Quantized Signal');
xlabel('Frequency (Hz)'); ylabel('|MQ(f)|'); grid on;

subplot(3,1,3);
plot(f,MD_f);
title('Spectrum of Decoded Signal');
xlabel('Frequency (Hz)'); ylabel('|MD(f)|'); grid on;
