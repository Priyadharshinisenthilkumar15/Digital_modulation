
% M-ARY M= 4

clc;
clear;
close all;

M = 4;
k = log2(M);          
Tb = 1;               
fc = 5;
fs = 200;
t = 0:1/fs:Tb-1/fs;  

bits = [1 0 1 1 0 0 0 1];

L = floor(length(bits)/k)*k;
bits = bits(1:L);

symbols = bi2de(reshape(bits,k,[]).','left-msb');

A = [-3 -1 1 3];

bit_signal = repelem(bits,length(t)/k);

carrier = cos(2*pi*fc*(0:1/fs:length(symbols)*Tb-1/fs));

ask_signal = [];
for i = 1:length(symbols)
    ask_signal = [ask_signal A(symbols(i)+1)*cos(2*pi*fc*t)];
end

demod_signal = ask_signal .* carrier;

decoded_symbols = [];
for i = 1:length(symbols)

    segment = demod_signal((i-1)*length(t)+1 : i*length(t));
   
    value = (2/length(t)) * sum(segment);

    [~,index] = min(abs(value - A));
    decoded_symbols = [decoded_symbols index-1];
end

decoded_bits = reshape(de2bi(decoded_symbols,k,'left-msb').',1,[]);

figure;
sgtitle("Priyadharshini EC23I1010");
subplot(5,1,1)
stairs(bit_signal,'LineWidth',1.5)
title('Message Bit Sequence')
ylim([-0.5 1.5])

subplot(5,1,2)
plot(carrier,'LineWidth',1)
title('Carrier Signal')

subplot(5,1,3)
plot(ask_signal,'LineWidth',1)
title('4-ASK Modulated Signal')

subplot(5,1,4)
plot(demod_signal,'LineWidth',1)
title('Demodulated Signal')

subplot(5,1,5)
stairs(repelem(decoded_bits,length(t)/k),'LineWidth',1.5)
title('Decoded Bit Sequence')
ylim([-0.5 1.5])

disp('Original Bits:')
disp(bits)

disp('Decoded Bits:')
disp(decoded_bits)
