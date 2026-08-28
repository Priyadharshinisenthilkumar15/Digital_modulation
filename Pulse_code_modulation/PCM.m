% PCM Simulation of a Sinusoidal Signal

f = 1;              
fs = 100;          
t = 0:1/fs:1;       
a = 1;              
x = a * sin(2*pi*f*t); 

bits = [1, 2, 3, 4]; 

figure('Name', 'PCM Quantization Levels');

for i = 1:length(bits)
    N = bits(i);
    L = 2^N;        
  
    v_max = a;
    v_min = -a;
    step = (v_max - v_min) / L;
   
    partition = v_min + step : step : v_max - step;
    codebook = v_min + step/2 : step : v_max - step/2;
    
    [index, quants] = quantiz(x, partition, codebook);
    
    % Plotting
    subplot(2, 2, i);
    plot(t, x, 'r--'); hold on;
    stairs(t, quants, 'b', 'LineWidth', 1.5); 
    grid on;
    title(['N = ', num2str(N), ' Bits (', num2str(L), ' Levels)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Analog', 'Quantized');
end
