
%BFSK WITH AWGN 

Tb = 1;
fs = 1000;
t = 0:1/fs:Tb-1/fs;

f1 = 5;
f0 = 2;

bits = [1 0 1 1 0 0 1];
N = length(bits);

% Message Signal
msg = [];
for i = 1:N
    msg = [msg bits(i)*ones(1,length(t))];
end

% Carrier signals
c1 = cos(2*pi*f1*t);
c0 = cos(2*pi*f0*t);

% BFSK Modulation
bfsk = [];
for i = 1:N
    if bits(i)==1
        bfsk = [bfsk cos(2*pi*f1*t)];
    else
        bfsk = [bfsk cos(2*pi*f0*t)];
    end
end

% Time axis
time = 0:1/fs:N*Tb-1/fs;

% Add AWGN Noise
snr = 5;
noisy_signal = awgn(bfsk,snr,'measured');

% Demodulation
decoded = [];
demod_wave = [];

x1_vals = [];
x0_vals = [];

for i = 1:N
    
    segment = noisy_signal((i-1)*length(t)+1:i*length(t));
    
    r1 = segment .* cos(2*pi*f1*t);
    r0 = segment .* cos(2*pi*f0*t);
    
    demod_wave = [demod_wave r1];
    
    x1 = sum(r1);
    x0 = sum(r0);
    
    x1_vals = [x1_vals x1];
    x0_vals = [x0_vals x0];
    
    if x1 > x0
        decoded = [decoded 1];
    else
        decoded = [decoded 0];
    end
end

% Decoded waveform
decoded_wave = [];
for i = 1:length(decoded)
    decoded_wave = [decoded_wave decoded(i)*ones(1,length(t))];
end

% Plots
figure
sgtitle("Priyadharshini.S EC23I1010")
subplot(6,1,1)
plot(time,msg)
title('Original Message Signal')
ylim([-0.5 1.5])

subplot(6,1,2)
plot(t,c1)
hold on
plot(t,c0)
title('Carrier Signals')
legend('Carrier for bit 1','Carrier for bit 0')

subplot(6,1,3)
plot(time,bfsk)
title('BFSK Modulated Signal')

subplot(6,1,4)
plot(time,noisy_signal)
title('BFSK Signal with AWGN Noise')

subplot(6,1,5)
plot(time,demod_wave)
title('Demodulated Signal')

subplot(6,1,6)
stem(1:N,x1_vals)
hold on
stem(1:N,x0_vals)
title('Correlation Outputs (x1 and x0)')
legend('x1','x0')

disp('Original Bits:')
disp(bits)

disp('Decoded Bits:')
disp(decoded)
