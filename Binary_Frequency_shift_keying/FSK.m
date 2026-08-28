%BFSK MODULATION AND DEMODULATION 

Tb = 1;                 
fs = 1000;             
t = 0:1/fs:Tb-1/fs;     
f1 = 5;                 
f0 = 2;                 
bits = [1 0 1 1 0 0 1]; 
N = length(bits);

% Message waveform
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
    if bits(i) == 1
        bfsk = [bfsk cos(2*pi*f1*t)];
    else
        bfsk = [bfsk cos(2*pi*f0*t)];
    end
end
% Time axis
time = 0:1/fs:N*Tb-1/fs;

% Demodulation
decoded = [];
demod_wave = [];
for i = 1:N
    
    segment = bfsk((i-1)*length(t)+1:i*length(t));
    
    r1 = segment .* cos(2*pi*f1*t);
    r0 = segment .* cos(2*pi*f0*t);
    
    demod_wave = [demod_wave r1];  
    
    x1 = sum(r1);
    x0 = sum(r0);
    
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

% Plotting
figure
sgtitle("Priyadharshini.S EC23I1010")
subplot(5,1,1)
plot(time,msg,'LineWidth',2)
title('Message Bit Sequence')
ylim([-0.5 1.5])

subplot(5,1,2)
plot(t,c1,'LineWidth',1.5)
hold on
plot(t,c0,'LineWidth',1.5)
title('Carrier Signals')
legend('Carrier for 1','Carrier for 0')

subplot(5,1,3)
plot(time,bfsk,'LineWidth',1.5)
title('BFSK Modulated Signal')

subplot(5,1,4)
plot(time,demod_wave,'LineWidth',1.5)
title('Demodulated Signal')

subplot(5,1,5)
plot(time,decoded_wave,'LineWidth',2)
title('Decoded Bit Sequence')
ylim([-0.5 1.5])
