function Power = op_power_filteredandsquare(sig)
% 将输入的 sig 经过不同频率段的滤波，读取默认的滤波器。
%滤波器设计时候是按 Fs = 1000Hz 设计的，若采样频率不对，自行从新设计
% 输入若为矩阵，则每一个为一个信号

Numsig = size(sig,1);
Power = zeros(Numsig,5);
for i = 1 : Numsig
    sig1 = sig(i,:);
    
    load('filter0.5-3Hz.mat');   % 读取不同的滤波器
    Hd_detla = Hd;
    load('filter3-8Hz.mat');
    Hd_theta = Hd;
    load('filter8-12Hz.mat');
    Hd_alpha = Hd;
    load('filter12-30Hz.mat');
    Hd_beta = Hd;
    load('filter30-80Hz.mat');
    Hd_gamma = Hd;
    
    fil_detla = filter(Hd_detla,sig1);
    fil_theta = filter(Hd_theta,sig1);
    fil_alpha = filter(Hd_alpha,sig1);
    fil_beta = filter(Hd_beta,sig1);
    fil_gamma = filter(Hd_gamma,sig1);
    
    power_detla = sum(fil_detla.^2);
    power_theta = sum(fil_theta.^2);
    power_alpha = sum(fil_alpha.^2);
    power_beta = sum(fil_beta.^2);
    power_gamma = sum(fil_gamma.^2);
    
    Power(i,:) = [power_detla,power_theta,power_alpha,power_beta,power_gamma];
    
end