%%Steepest descent method  %%%%%%



 clc;clear;clearvars;
 close all;
 

format long;
syms x1 x2;
f1= 8*x1^2 -6*x1*x2 + 8*x2^2 -x1+x2;
fx=inline(f1);% converts to a functionsf
f= @(x) fx(x(:,1),x(:,2));% converts the input as a vector instead of two separate values
%fx(1,1); 

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
title('Steepest Descent Method')
grid on
hold on






grad=gradient(f1);
gx=inline(grad);
g= @(x) gx(x(:,1),x(:,2));

h1=hessian(f1);
hx=inline(h1);
x0=[100 0];
maxiter=4;
tol=1e-3;
iter=0;
X=[];

while norm(g(x0))>tol && iter<maxiter
    X=[X;x0];
    S=-g(x0);
    H=hx(x0);
    lam=S'*S./(S'*H*S);
    Xnew=x0+lam.*S';
    x0=Xnew;
    iter=iter+1;
     hold on
    %update the optimum point on plot
   % plot(x0(i),x0(i),'*-r');
 end   
 X=[X;x0];
fprintf('optimal value x=[%f, %f]\n',x0(1),x0(2))
fprintf('optimal value f=%f \n',f(x0))

%{
figure()
fc= @(x,y) 8*x^2 -6*x*y + 8*y^2 -x+y;
fcontour(fc,'Fill','On');
colorbar;
xlabel('x1')
ylabel('x2')
title('Steepest descent')
grid on
hold on;
plot(X(:,1),X(:,2),'*-r');
%}

plot(X(:,1),X(:,2),'*-r');
i=iter;
% Result Table:`
Iter = 0:i;
X_coordinate =X(:,1);
Y_coordinate = X(:,2);
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);
%figure();
hold on

text(0,-2,['optimum point [x1*,x2*] = ','[' num2str(X(i+1,1)),', ',num2str(X(i+1,2)),']',],'Color','k')

disp(T)