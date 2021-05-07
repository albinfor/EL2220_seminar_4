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
xlabel('x, fish capacity achieved')
ylabel('y, newborn fish per year')

c_1 = 30;
c_2 = 5;
f_e = @(x) c_1*(c_2*x)./(1+(c_2*x));
x_loss = f_e(x_norm);
figure(2)
plot(x_norm,x_loss);
axis([0 1 0 28])
grid on
title('f_e(x)')
xlabel('x, fish capacity achieved')
ylabel('y, fish per boat per year')

%% problem 1.2c

x_dot=@(x,y) f_r(x./x_max)-y.*f_e(x./x_max);
[X,Y]=meshgrid(0:50:2000,0:5:200);
z=x_dot(X,Y);
figure(5)
%quiver(X,Y,z,zeros(size(z)))
surf(X,Y,z)
grid on
title('$\dot{x}(x,y)$','interpreter','latex')
xlabel('x, number of fish')
ylabel('y, number of ships')
axis([0 2000 0 200 -2000 600])
colorbar
caxis([-2000,500])


%% problem 1.2d
figure(6)
[X,Y]=meshgrid(0:50:2000,0:5:200);
z=x_dot(X,Y);
contour(X,Y,z,[0,0])
grid on
title('Equilibrium points')
xlabel('x, number of fish')
ylabel('y, number of ships')
axis([0 2000 0 30 0 600])

%% problem 1.2e

% The tipping point is at (x,y) = (1300, 24)
% If there are less than 1300 fish and we are to the left of the curve in
% 1.2d, all fish will eventually die. If the number of fish is above 1300,
% a boath population of 24 or less is sustainable, as no matter what, we
% will reach the equalibrium line that is not along the y-axis.

%% problem 1.3f
k_y = [0.1,1];
c = [20,24];

for i=[1,2]
    for j= [1,2]
        x_dot=@(x,y) f_r(x./x_max)-y.*f_e(x./x_max);
        y_dot = @(x,y) k_y(i).*y.*(f_e(x./x_max)-c(j));

        x_dot=@(x,y) f_r(x./x_max)-y.*f_e(x./x_max);
        [X,Y]=meshgrid(0:100:2000,0:10:100);
        x_d=x_dot(X,Y);
        y_d=y_dot(X,Y);
        figure(7)
        quiver(X,Y,x_d,y_d)
        hold on
        [Xa,Ya]=meshgrid(0:10:2000,0:5:200);
        z=x_dot(Xa,Ya);
        contour(Xa,Ya,z,[0,0])
        starty = 0:10:100;
        startx = ones(size(starty))*2000;
        streamline(X,Y,x_d,y_d,startx,starty)

        starty = [0,5,10,15,20,25,30,35,40];
        startx = ones(size(starty))*800;

        streamline(X,Y,x_d,y_d,startx,starty)
        hold off
        axis([0 2000 0 100])
        xlabel('number of fish')
        ylabel('number of ships')
        title("k_c = "+num2str(k_y(i))+" c = "+num2str(c(j)))
        
        saveas(gcf,int2str(i*(j+1)),'eps')
    end
end

%% problem 1.2g

% If the cost of catching fish is reduced less fish are needed to be caught
% to turn a profit leading to more ships and in turn fewer fish in the sea.
% All fish must die.

%% problem 1.2h

% If the fish industry is subidized, less fish are needed to be caught to
% turn a profit, hence look at 1.2g to see that more fish will die. If
% instead taxes were levied on the fish industry, the cost of fishing woul
% d increase, leading to more fish in the sea.