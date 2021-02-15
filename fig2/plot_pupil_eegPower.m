function plot_pupil_eegPower(bined_pupil, power_time, sP)

figure
subplot(611)
plot(power_time, bined_pupil)
xlim([power_time(1), power_time(end)])

subplot(612)
plot(power_time, sP.alpha)
xlim([power_time(1), power_time(end)])

subplot(613)
plot(power_time, sP.beta)
xlim([power_time(1), power_time(end)])

subplot(614)
plot(power_time, sP.detla)
xlim([power_time(1), power_time(end)])

subplot(615)
plot(power_time, sP.gamma)
xlim([power_time(1), power_time(end)])

subplot(616)
plot(power_time, sP.theta)
xlim([power_time(1), power_time(end)])