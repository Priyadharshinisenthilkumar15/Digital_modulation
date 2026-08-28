%2. Frequency modulation and Bandwidth calculation using Carson's rule

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

BW = 2 * (delta_f + fm);

fprintf('Frequency Deviation  = %d Hz\n', delta_f);
fprintf('Modulation Index = %.2f\n', beta);
fprintf('FM Bandwidth (Carson Rule) = %d Hz\n', BW);

figure;

subplot(3,1,1);
plot(t, m);
title('Message Signal');
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
plot(t, cos(2*pi*fc*t));
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
