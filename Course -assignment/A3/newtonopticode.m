%%% newton
 clc
 clear
 clearvars
format long
syms x1 x2;

f1 = 8*x1^2-6*x1*x2+8*x2^2 -x1 +x2;
%x_1(1) = 100;

%x_2(1) = 0;
x0=[100, 0]
%x_1(1) = x(1);
%x_2(1) = x(2);
tol=1e-3; 
i = 0; 

x1Label = linspace(-100,150,100);
x2Label = linspace(-100,150,100);
[X,Y] = meshgrid(x1Label,x2Label);
f2 =  8*X.^2-6*X.*Y+8*Y.^2-X+Y;  % objective Function 
figure()
contour(X,Y,f2,'Fill','On')
colorbar;
hold on
plot(x0(1),x0(2),'*-k');
text(100,0,['(x0) = (' num2str(x0(1)),', ',num2str(x0(2)) ')'],'Color','k')
xlabel('x1')
ylabel('x2')
title('Newton Method')
grid on
hold on
% Gradient Computation:
%df_dx1 = diff(f, x1);
%df_dx2 = diff(f, x2);
grad=gradient(f1);
gx=inline(grad);
g= @(x) gx(x(:,1),x(:,2));
h1=hessian(f1);
hx=inline(h1);
%J = [subs(df_dx1,[x1,x2], [x_1(1),x_2(1)]) subs(df_dx2, [x1,x2], [x_1(1),x_2(1)])]; % Gradient
%S = -g(x0)
maxiter =4;
iter=1;
X=[];

while norm(g(x0))>tol && iter<maxiter
    X=[X;x0];
   % S=g(x0);
    H=hx(x0);
    invH=inv(H);
    Xnew=x0'-invH*g(x0);
    x0=Xnew';
    iter=iter+1;
    i=i+1;
    plot(x0(1),x0(2),'*-k');
end  
  X=[X;x0];
  
% Result Table:`
%Iter = 0:1:i;
X_coordinate = X(:,1);
Y_coordinate = X(:,2);
%Iterations = Iter';
T = table(X_coordinate,Y_coordinate);
%figure();
hold on
%plot(x_1,x_2,'*-r');
plot(X(:,1),X(:,2),'*-r');
hold on
%plot(x_1(i),x_2(i),'*-k');
plot(X(i,1),X(i,2),'*-r');
hold on
%plot(x_1(1),x_2(1),'*-k');
plot(X(1,1),X(1,2),'*-r');
hold on
text(0,-2,['(x1*,x2*) = ','[' num2str(X(i+1,1)),', ',num2str(X(i+1,2)),']',],'Color','k')

fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', X(i+1,1),X(i+1,2));
fprintf('Objective Function Minimum Value: %d\n\n', subs(f1,[x1,x2], [X(i+1,1),X(i+1,2)]));
disp(T)
