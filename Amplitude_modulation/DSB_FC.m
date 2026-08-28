Am = 1;          
Ac = 2;         
fm = 10;         
fc = 100;        
Fs = 5000;       
t = 0:1/Fs:0.5;
mu_values = [0.3 0.7 1.0 1.5];

m = Am*cos(2*pi*fm*t);
c = cos(2*pi*fc*t);

for k = 1:length(mu_values)

    mu = mu_values(k);
    s = Ac*(1 + mu*m).*c;

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

   
    figure('Name',['DSB-FC for \mu = ',num2str(mu)],'NumberTitle','off')
    sgtitle('PRIYADHARSHINI.S EC23I1010')

    subplot(5,1,1)
    plot(t,m,'b')
    title('Message Signal')
    grid on

    subplot(5,1,2)
    plot(t,c,'r')
    title('Carrier Signal')
    grid on

    subplot(5,1,3)
    plot(t,s,'k')
    title(['AM Modulated Signal (DSB-FC), \mu = ',num2str(mu)])
    grid on

    subplot(5,1,4)
    plot(t,demod,'g')
    title('Demodulated Signal (Coherent Detection)')
    grid on

    subplot(5,1,5)
    plot(f,S_mag)
    title('Spectrum of Modulated Signal')
    xlim([-300 300])
    grid on
end
