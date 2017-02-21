scrsz = get(0,'ScreenSize');
figure1=figure('Position',[0 30 scrsz(3) scrsz(4)-95]);
x=rand(100,1);
plot(x);
% saveas(gcf,'filename','bmp');
% saveas(gcf,'filename','emf');
saveas(gcf,'filename','jpg');
clear all; clc; close all;