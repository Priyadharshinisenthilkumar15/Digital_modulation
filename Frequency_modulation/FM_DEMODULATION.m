%3. Demodulation of FM signal

Am = 1;  
Ac = 2;
fm = 10;           
fc = 100;          
fs = 5000;         
kf = 50;          
t = 0:1/fs:0.5;  

m = Am * cos(2*pi*fm*t);
delta_f = kf * Am;
beta = delta_f / fm;

fm_signal = Ac * cos(2*pi*fc*t + beta * sin(2*pi*fm*t));
hilbert_signal = hilbert(fm_signal);

inst_phase = unwrap(angle(hilbert_signal));
inst_freq = diff(inst_phase) * fs / (2*pi);
inst_freq = [inst_freq inst_freq(end)]; 

demod_signal = (inst_freq - fc) / kf;
demod_signal = demod_signal / max(abs(demod_signal));

figure;

subplot(3,1,1);
plot(t, m);
title('Original Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, fm_signal);
title('FM Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, demod_signal,'r');
hold on;
plot(t, m,'--k');
title('Comparison of Message and Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Demodulated Signal','Original Message');
grid on;


