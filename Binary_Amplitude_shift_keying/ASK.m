%BINARY ASK 

bits = [1 0 1 1 0 0 1];   
Tb = 1;                
fc = 5;             
fs = 100;               
A = 1;                  
t = 0:1/fs:Tb-1/fs;      
message_signal =[];
bask_signal = [];
carrier_signal = [];

for i = 1:length(bits)
    
    if bits(i) == 1
        m = ones(1,length(t));        
    else
        m = zeros(1,length(t));         
    end
    
    c = A*cos(2*pi*fc*t);              
    s = m .* c;                        
    
    message_signal = [message_signal m];
    carrier_signal = [carrier_signal c];
    bask_signal = [bask_signal s];
end

total_time = 0:1/fs:Tb*length(bits)-1/fs;

demod_signal = bask_signal .* carrier_signal;

decoded_bits = [];
demodulated_output = [];

for i = 1:length(bits)
    
    segment = demod_signal((i-1)*length(t)+1 : i*length(t));
    value = trapz(segment);   
    
    demodulated_output = [demodulated_output segment];
    
    if value > 0.25*Tb*fs     
        decoded_bits = [decoded_bits 1];
    else
        decoded_bits = [decoded_bits 0];
    end
end

disp('Original Bits:');
disp(bits);

disp('Decoded Bits:');
disp(decoded_bits);

figure;
sgtitle("Priyadharshini EC23I1010");
subplot(5,1,1)
plot(total_time, message_signal,'LineWidth',1.5)
title('Message Bit Sequence')
ylim([-0.5 1.5])
grid on

subplot(5,1,2)
plot(total_time, carrier_signal,'LineWidth',1)
title('Carrier Signal')
grid on

subplot(5,1,3)
plot(total_time, bask_signal,'LineWidth',1.5)
title('BASK Modulated Signal')
grid on

subplot(5,1,4)
plot(total_time, demodulated_output,'LineWidth',1)
title('Demodulated Signal (After Multiplication)')
grid on

subplot(5,1,5)
stairs(0:length(decoded_bits)-1, decoded_bits,'LineWidth',2)
title('Decoded Bit Sequence')
ylim([-0.5 1.5])
grid on
