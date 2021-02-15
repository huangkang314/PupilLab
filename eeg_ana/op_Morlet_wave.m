function morlet_wave = op_Morlet_wave(t,fb,fc)
% 产生一个中心频率为fc，贷款为fb的molerlet小波
morlet_wave = 1/sqrt(pi*fb)*exp(1i*2*pi*fc*t).*exp(-t.^2/fb);

% plot(imag(morlet_wave))