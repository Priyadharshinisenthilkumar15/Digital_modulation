Am = 1;         
Ac = 2;         
fm = 10;        
fc = 100;        

Fs = 5000;       
t = 0:1/Fs:0.5;  

m = Am*cos(2*pi*fm*t);
c = cos(2*pi*fc*t);
s = Ac * m .* c;

local_carrier = cos(2*pi*fc*t);
product = s .* local_carrier;

N = length(product);
PRODUCT_F = fft(product);
f = (-N/2:N/2-1)*(Fs/N);

LPF = abs(f) <= fm;                 
DEMOD_F = fftshift(PRODUCT_F) .* LPF;
demod = real(ifft(ifftshift(DEMOD_F)));
demod = demod - mean(demod);
demod = demod / max(abs(demod));

S = fft(s,N);
S_mag = abs(fftshift(S))/N;

figure('Name','DSB-SC with Coherent Detection','NumberTitle','off')
sgtitle('PRIYADHARSHINI.S EC23I1010')

subplot(5,1,1)
plot(t,m,'b')
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(5,1,2)
plot(t,c,'r')
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(5,1,3)
plot(t,s,'k')
title('DSB-SC Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(5,1,4)
plot(t,demod,'g')
title('Demodulated Signal (Coherent Detection)')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(5,1,5)
plot(f,S_mag)
title('Spectrum of DSB-SC Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([-300 300])
grid on
