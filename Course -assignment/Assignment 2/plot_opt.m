
x=linspace(0,3,100);
y=equation_func(x);
figure;
plot(x,y)
grid on;
title('Plot')
ylabel('\tau_(xy)/P_(max)')
xlabel('\lambda')
hold on
plot(0.75,0.3,'o','Markersize',8);