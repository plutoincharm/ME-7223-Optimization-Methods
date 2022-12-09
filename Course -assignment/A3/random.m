clc
clear all
close all;

Y = [0;0];



h = 0.05;
n = 100;
f = Y(1) - Y(2) + 2*Y(1)^2 + 2*Y(1)*Y(2) + Y(2)^2; %100*(X(2) - X(1)^2)^2 + (1 - X(1))^2;
lambda = 1;

while lambda >= h
    
    flag1 = 0;
    while flag1 == 0
        i = 1;
        while i<= n
            
            flag = 0;
            while flag == 0
                 r = -1 + (2).*rand(2,1);
                 val = norm(r);
                 if val <= 1
                     flag = 1;
                     break
                 else
                     flag = 0;
                 end
            end
            u = r/norm(r);
            X1 = Y + lambda*u;
            f1 = X1(1) - X1(2) + 2*X1(1)^2 + 2*X1(1)*X1(2) + X1(2)^2;
            if f<f1
                Y = X1;
                f = f1;
                flag1 = 1;
                break
            elseif f>= f1
                i = i+1;
            end
        end
        
    end
    
    
    lambda = lambda/2;
end
    
