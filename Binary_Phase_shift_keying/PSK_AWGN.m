%effect of AWGN on demodulated signal

bits = [1 0 1 1 0 0 1];
Tb = 1;
fs = 1000;
t = 0:1/fs:Tb-1/fs;
fc = 5;
N = length(bits);
msg = [];

for i = 1:N
    msg = [msg bits(i)*ones(1,length(t))];
end

time = 0:1/fs:N*Tb-1/fs;
carrier = cos(2*pi*fc*time);

mapped = [];
for i = 1:N
    if bits(i)==1
        mapped = [mapped ones(1,length(t))];
    else
        mapped = [mapped -ones(1,length(t))];
    end
end

bpsk = mapped .* carrier;
SNR = 5; 
noisy_signal = awgn(bpsk,SNR,'measured');

demod = noisy_signal .* carrier;

samples_per_bit = length(t);
demod_bits = [];

for i = 1:N
    segment = demod((i-1)*samples_per_bit+1:i*samples_per_bit);
    
    if sum(segment) > 0
        demod_bits = [demod_bits 1];
    else
        demod_bits = [demod_bits 0];
    end
end

demod_signal = [];
for i = 1:N
    demod_signal = [demod_signal demod_bits(i)*ones(1,length(t))];
end

figure
sgtitle("Priyadharshini.S EC23I1010");

subplot(5,1,1)
stairs(time,msg,'LineWidth',2)
title('Message Signal')
ylim([-0.5 1.5])

subplot(5,1,2)
plot(time,bpsk)
title('BPSK Modulated Signal')

subplot(5,1,3)
plot(time,noisy_signal)
title('BPSK Signal with AWGN Noise')

subplot(5,1,4)
plot(time,demod)
title('Demodulated Signal')

subplot(6,1,6)
x = 0:length(bits);
stairs(x,[bits bits(end)],'b','LineWidth',2)
hold on
stairs(x,[demod_bits demod_bits(end)],'r--','LineWidth',2)
title('Comparison: Original vs Demodulated Bits')
legend('Original','Demodulated')

ylim([-0.5 1.5])
xlim([0 length(bits)])
