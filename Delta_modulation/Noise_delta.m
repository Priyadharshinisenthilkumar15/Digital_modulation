Am = 1;
fm = 2;
fs = 500;
t = 0:1/fs:2;

m = Am*sin(2*pi*fm*t);
delta_optimal = 2*pi*fm*Am/fs;

% 1. Slope Overload Distortion

delta_small = delta_optimal/4;
mq_slope = zeros(size(m));

for n = 2:length(m)
    if m(n) >= mq_slope(n-1)
        mq_slope(n) = mq_slope(n-1) + delta_small;
    else
        mq_slope(n) = mq_slope(n-1) - delta_small;
    end
end

figure;
plot(t,m,'k',t,mq_slope,'r','LineWidth',1.5);
title('Slope Overload Distortion (Small \Delta)');
legend('Message','DM Output');
grid on;

% 2. Granular Noise 
delta_large = 4*delta_optimal;
mq_gran = zeros(size(m));

for n = 2:length(m)
    if m(n) >= mq_gran(n-1)
        mq_gran(n) = mq_gran(n-1) + delta_large;
    else
        mq_gran(n) = mq_gran(n-1) - delta_large;
    end
end

figure;
plot(t,m,'k',t,mq_gran,'b','LineWidth',1.5);
title('Granular Noise (Large \Delta)');
legend('Message','DM Output');
grid on;
