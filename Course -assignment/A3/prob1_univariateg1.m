% Guess point  of my choice
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
format long
close all;
syms X Y;
f =100*(Y-X^2)^2 + (1-X)^2;
% Initial Guess 
x(1) = 0;
y(1) = 0;
S = [1 0]';
I = [x(1),y(1)]';
%step length
e = 0.01;
i = 1;
% direction along S
F = subs(f, [X,Y], [x(1),y(1)]);
f_plus = I + e*S;
F_plus = subs(f, [X,Y], [f_plus(1), f_plus(2)]);
f_minus = I - e*S;
F_minus = subs(f, [X,Y], [f_minus(1), f_minus(2)]);

if F_minus < F
    S = -S;
else
    S = S;
end

while ((double(F) > double(F_minus))||(double(F) > double(F_plus)))
    syms lam; 
    g = subs(f, [X,Y], [x(i)+S(1)*lam,y(i)+lam*S(2)]);
    dg_dh = diff(g,lam);
    lam = vpa(solve(dg_dh==0,lam),6);
    lambda = lam(imag(lam)==0);
        for k = 1:size(lambda)
            fun_lambda_value(k) = subs(f,[X,Y],[x(i)+lambda(k,1)*S(1),y(i)+lambda(k,1)*S(2)]);
        end
    [value, index] = min(fun_lambda_value);
        
    lambda = lambda(index);


    x(i+1) = I(1)+lambda*S(1); 
    y(i+1) = I(2)+lambda*S(2); 
    i = i+1;
    I = [x(i),y(i)]'; 
    if rem(i,2) == 0
        S = [0 1]';
    else
        S = [1 0]';
    end
    F = subs(f, [X,Y], [x(i),y(i)]);
    f_plus = I + e*S;
    F_plus = subs(f, [X,Y], [f_plus(1), f_plus(2)]);
    f_minus = I - e*S;
    F_minus = subs(f, [X,Y], [f_minus(1), f_minus(2)]);
    if double(F_minus) < double(F)
        S = -S;
    else
        S = S;
    end
end
% Result Table:
Iter = 1:i;
X_coordinate = x';
Y_coordinate = y';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);
%{
fcontour(f,'Fill','On');
hold on;
colorbar ;
title('univaritae')
plot(x,y,'*-r');
scatter(x(i),y(i),'filled');
%}
x1Label = linspace(-2,2,100);
x2Label = linspace(-2,2,100);
[V,D] = meshgrid(x1Label,x2Label);
f2 =  100*(D-V.^2).^2+ (1-V).^2;  % objective Function 
figure()
contour(V,D,f2,'Fill','On')
colorbar;
hold on
%plot(X(1),X(2),'*-k');
text(100,0,['(x0) = (' num2str(x(1)),', ',num2str(y(2)) ')'],'Color','k')
xlabel('x1')
ylabel('x2')
title('univariate')
plot(x,y,'*-r');
grid on
hold on
scatter(x(i),y(i),'filled');

disp(T)
