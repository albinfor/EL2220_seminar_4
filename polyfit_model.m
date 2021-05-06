%% f_r
%region 1, for x<0.2
x = [0, .10, .20];
y = [0, 50, 100];
p1 = polyfit(x,y,1);
%region 2, for x>0.4 and x<0.7
x = [.20, .30, .40];
y = [100, 200, 300];
p2 = polyfit(x,y,1);
%region 3, for x>0.4 and x<0.5
x = [0.40, .50];
y = [300, 500];
p3 = polyfit(x,y,1);
%region 4, for x>0.5 and x<0.7
x = [.50, .60, .70];
y = [500, 550, 480];
p4 = polyfit(x,y,2);
%region 5, for x>0.7
x = [.70, .80, .90, 1];
y = [480, 280, 130, 0];
p5 = polyfit(x,y,1);


%% f_e