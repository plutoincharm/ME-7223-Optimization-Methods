clc
clear all
clearvars
close all;
%initial point
X = [-0.5;0.5];
S1 = [1;0];
S2 = [0;1];
e = 0.01;


x1Label = linspace(-2,2,100);
x2Label = linspace(-2,2,100);
[V,D] = meshgrid(x1Label,x2Label);
f2 =  100*(D-V.^2).^2+ (1-V).^2; % objective Function 
figure()
contour(V,D,f2,'Fill','On')
colorbar;
hold on
plot(X(1),X(2),'*-k');
text(100,0,['(x0) = (' num2str(X(1)),', ',num2str(X(2)) ')'],'Color','k')
xlabel('x1')
ylabel('x2')
title('Powell')
grid on
hold on
scatter(X(1),X(2),'filled')






for i=1:16   

    Sol = zeros(2,4);
    Sol(:,1) = X;
    
    f = 100*(X(2) - X(1)^2)^2 + (1 - X(1))^2;%initial value
    S = S1;
  
    X2 = X - e*S;
    
    f2 = 100*(X2(2) - X2(1)^2)^2 + (1 - X2(1))^2;
    if f2<f
        S = -S;
    end
    fun = @(lambda) 100*( X(2) + lambda*S(2) - (X(1) + lambda*S(1))^2)^2 + (1 - (X(1) + lambda*S(1)))^2;
    l = fminbnd(fun,-2,2);

    X = X + l*S; 
    Sol(:,2) = X;
    plot([Sol(1,1) Sol(1,2)], [Sol(2,1) Sol(2,2)])

    f = 100*(X(2) - X(1)^2)^2 + (1 - X(1))^2;
    S = S2;
    X2 = X - e*S;
    f2 = 100*(X2(2) - X2(1)^2)^2 + (1 - X2(1))^2;
    if f2<f
        S = -S;
    end
    fun = @(lambda)100*( X(2) + lambda*S(2) - (X(1) + lambda*S(1))^2)^2 + (1 - (X(1) + lambda*S(1)))^2;
    l = fminbnd(fun,-2,2);
    %l = 0.05;
    X = X + l*S;
    Sol(:,3) = X;
    plot([Sol(1,2) Sol(1,3)], [Sol(2,2) Sol(2,3)])

    f = 100*(X(2) - X(1)^2)^2 + (1 - X(1))^2;
    S = S1;
    X1 = X + e*S;
    X2 = X - e*S;
    %f1 = 100*(X1(2) - X1(1)^2)^2 + (1 - X1(1))^2;
    f2 = 100*(X2(2) - X2(1)^2)^2 + (1 - X2(1))^2;
    if f2<f
        S = -S;
    end
    fun = @(lambda) 100*( X(2) + lambda*S(2) - (X(1) + lambda*S(1))^2)^2 + (1 - (X(1) + lambda*S(1)))^2;
    l = fminbnd(fun,-2,2);

    X = X + l*S;

    Sol(:,4) = X;
    hold on
    plot([Sol(1,3) Sol(1,4)], [Sol(2,3) Sol(2,4)])



    S3 = Sol(:,4) - Sol(:,2);
    S3 = S3/norm(S3);
    S2 = S1;
    S1 = S3;
    
 
end



% Result Table:`

X_opti = X(1)';
Y_opti = X(2)';
T = table(X_opti,Y_opti );
disp(T)
hold on
scatter(X(1),X(2),'filled');
