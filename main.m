%% Problem 1.2
clc; clear;
x_max = 2000;
x = linspace(0,x_max)';
x_norm = x/x_max;

x_weight = [0,0.3,0.45,1];
y_weight = [0,-0.03, 0.01 ,0];
p = polyfit(x_weight, y_weight, 3);

x_reweigh = @(x) (1+polyval(p,x)).*x;

f_r = @(x) 3713.7.*(x.^2.*(1-x));
x_growth = f_r(x_reweigh(x_norm));
figure(1)
plot(x_norm,x_growth);
grid on
title('f_r(x)')


c_1 = 30;
c_2 = 0.0025*2000;
f_e = @(x) c_1*(c_2*x)./(1+(c_2*x));
x_loss = f_e(x_norm);
figure(2)
plot(x_norm,x_loss);
axis([0 1 0 28])
grid on
title('f_e(x)')

%% problem 1.2c

f=@(x,y) f_r(x./x_max)-y.*f_e(x./x_max);
[X,Y]=meshgrid(0:100:2000,0:5:200);
z=f(X,Y);
figure(4)
surf(X,Y,z)



