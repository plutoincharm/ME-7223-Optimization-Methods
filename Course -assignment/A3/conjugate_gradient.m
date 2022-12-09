%%% conjuagate gardient
 clc
 clear
 clearvars
 close all;
format long
syms x1 x2;

f1 = 8*x1^2-6*x1*x2+8*x2^2 -x1 +x2;
%x_1(1) = 100;

%x_2(1) = 0;
x=[100, 0];
x_1(1) = x(1);
x_2(1) = x(2);
tol=1e-3; 
i = 1; 

x1Label = linspace(-120,120,100);
x2Label = linspace(-120,120,100);
[X,Y] = meshgrid(x1Label,x2Label);
f2 =  8*X.^2-6*X.*Y+8*Y.^2-X+Y;  % objective Function 
figure()
contour(X,Y,f2,'Fill','On')
colorbar;
hold on
%plot(x,'*-k');
%text(50,0,['Initial Point (x1,x2) = (' num2str(x_1(1)),', ',num2str(x_2(1)) ')'],'Color','k')
xlabel('x1')
ylabel('x2')
title('Conjugate gradient Method')
grid on
hold on
% Gradient Computation:
%df_dx1 = diff(f, x1);
%df_dx2 = diff(f, x2);
grad=gradient(f1);
gx=inline(grad);
g= @(x) gx(x(:,1),x(:,2));
%J = [subs(df_dx1,[x1,x2], [x_1(1),x_2(1)]) subs(df_dx2, [x1,x2], [x_1(1),x_2(1)])]; % Gradient
S = -g(x)
maxiter =4;
% Minimization Condition:
while norm(S)>tol && i<maxiter 
    I = [x_1(i),x_2(i)]';
    syms lambda; 
    gn = subs(f1, [x1,x2], [x_1(i)+S(1)*lambda,x_2(i)+lambda*S(2)]);
    %Optimize the step length
    dg_dlambda = (diff(gn,lambda)==0);
    lam = double(solve(dg_dlambda, lambda));
    hold on
    %update the optimum point on plot
    plot(x_1(i),x_2(i),'*-r');
    %hold on
    % Update the value
    x_1(i+1) = I(1)+lam*S(1); % New x value
    x_2(i+1) = I(2)+lam*S(2); % New y value
    
    %x(1,1)=[x_1(i),x_2(i)];
    x(1)=x_1(i);
    x(2)=x_2(i);
    gradi = g(x);
   % x(1,1)=[x_1(i+1),x_2(i+1)];
    x(1)=x_1(i+1);
    x(2)=x_2(i+1);
    gradiplus = g(x);

   % [subs(df_dx1,[x1,x2], [x_1(i),x_2(i)]) subs(df_dx2, [x1,x2], [x_1(i),x_2(i)])];
    i = i+1;
    %J_new = [subs(df_dx1,[x1,x2], [x_1(i),x_2(i)]) subs(df_dx2, [x1,x2], [x_1(i),x_2(i)])]; % Updated Gradient
    S = -(gradiplus)+((norm(gradiplus))^2/(norm(gradi))^2)*S; % New Searchx Direction
end
% Result Table:`
Iter = 1:i;
X_coordinate = x_1';
Y_coordinate = x_2';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);
%figure();
hold on
plot(x_1,x_2,'*-r');
hold on
%plot(x_1(i),x_2(i),'*-k');
%hold on
%plot(x_1(1),x_2(1),'*-k');
%hold on
text(0,-2,['optimum point [x1*,x2*] = ','[' num2str(x_1(i)),', ',num2str(x_2(i)),']',],'Color','k')
% Output:
fprintf('Initial Objective Function Value: %d\n\n',subs(f1,[x1,x2], [x_1(1),x_2(1)]));

fprintf('Number of Iterations for Convergence: %d\n\n', i-1);
fprintf('Point of Minima: [%d,%d]\n\n', x_1(i), x_2(i));
fprintf('Objective Function Minimum Value: %d\n\n', subs(f1,[x1,x2], [x_1(i),x_2(i)]));
disp(T)
