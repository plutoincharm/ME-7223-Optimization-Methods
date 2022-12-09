% EXTERIOR Penalty optimization Problem
% Once the problem is converted to unconstrained the conjugate gradient  method is used.

clc
clear
format long      
close all;


syms x1 x2;

f1 = (x1)^2+(x2)^2;
g1(1) = x1+2*x2-6;
g1(2) = x1-x2-3;


x1Label = linspace(-250,250,100);
x2Label = linspace(-150,150,100);
[X,Y] = meshgrid(x1Label,x2Label);
f2 =  (X)^2+(Y)^2;  % objective Function 
%g2 = X+2*Y-6;
%g3 = X-Y-3;
figure()
%contour(X,Y,f2,g2,g3,'Fill','On')
%hold on
contour(X,Y,f2,'Fill','On')
hold on
g2y = -120:1:120;
g2x = 6-2*g2y;
hold on
plot(g2x,g2y)
hold on
g3y = -120:1:120;
g3x = 3+g3y;
plot(g3x,g3y)
colorbar;
hold on
%plot(x,'*-k');
%text(50,0,['Initial Point (x1,x2) = (' num2str(x_1(1)),', ',num2str(x_2(1)) ')'],'Color','k')
xlabel('x1')
ylabel('x2')
title('Interior penalty method')
grid on
hold on














tol = 0.01;
con = 2; 
i = 1;
x_1(i) = 100;
x_2(i) = 0;
r = 0.001;
q=2;
fn = f1+ r*(g1(1)^q+g1(2)^q);

c=10;
    Gradf = gradient(fn);
    S = -subs(Gradf,[x1,x2],[x_1(i),x_2(i)]);
while con > tol && norm(S)> tol
        
        syms lambda
        f_lambda = subs(fn, [x1,x2], [x_1(i)+S(1)*lambda,x_2(i)+lambda*S(2)]);
        df_lambda = (diff(f_lambda,lambda));
        lambda = vpa(solve(df_lambda==0,lambda),6);
       lambda = lambda(imag(lambda)==0);
        for k = 1:size(lambda)
            fun_lambda_value(k) = subs(fn,[x1,x2],[x_1(i)+lambda(k,1)*S(1),x_2(i)+lambda(k,1)*S(2)]);
        end
        [value, index] = min(fun_lambda_value);
        
        lambda = lambda(index);
        
        x_1(i+1) = x_1(i)+lambda*S(1);
        x_2(i+1) = x_2(i)+lambda*S(2);
        Gradi = subs(Gradf,[x1,x2],[x_1(i),x_2(i)]);
        i = i+1
        Gradiplus = subs(Gradf,[x1,x2],[x_1(i),x_2(i)]);
        
        S = -(Gradiplus)+((norm(Gradiplus))^2/(norm(Gradi))^2)*S; 
    %end
    fobjminus = subs(f1,[x1,x2],[x_1(i-1),x_2(i-1)]);
    fobj = subs(f1,[x1,x2],[x_1(i),x_2(i)]);
    conv = abs(abs(fobj)-abs(fobjminus))/abs(fobj);
    r = c*r;      
    k= k+1;
    Gradf = gradient(fn);
    S = -subs(Gradf,[x1,x2],[x_1(i),x_2(i)]);
end

Iter = 1:i;
X_coordinate = x_1';
Y_coordinate = x_2';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);
hold on
plot(x_1(i),x_2(i),'*-r');
hold on
%plot(x_1(i),x_2(i),'*-k');
%hold on
%plot(x_1(1),x_2(1),'*-k');
%hold on
text(0,-2,['optimum point [x1*,x2*] = ','[' num2str(x_1(i)),', ',num2str(x_2(i)),']',],'Color','k')

disp(T)
