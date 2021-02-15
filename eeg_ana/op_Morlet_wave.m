function morlet_wave = op_Morlet_wave(t,fb,fc)
% ����һ������Ƶ��Ϊfc������Ϊfb��molerletС��
morlet_wave = 1/sqrt(pi*fb)*exp(1i*2*pi*fc*t).*exp(-t.^2/fb);

% plot(imag(morlet_wave))