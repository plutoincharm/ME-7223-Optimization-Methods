 %  Interval Halving Method 
%  a and b are the upper bound and lower bound of search space 
%  e is the desired minimum Interval Length 5 percent.
%  equation_func is the name of the function 
%  x1 and x2 are the lower and upper bound 


clc; clearvars;
a=0;b=3;

tol=0.05;
l=abs(b-a);
x_middle=(a+b)/2;
x1=a+l/4;
x2=b-l/4;
fx1=equation_func(x1);
fx2=equation_func(x2);
fxm=equation_func(x_middle);
while l>=tol
l=abs(b-a);
x1=a+l/4;
x2=b-l/4;
fx1=equation_func(x1);
fx2=equation_func(x2);
if fx2>=fxm
        a = x_middle;
        x_middle = x2;
        fxm = fx2;
    
    elseif fx1>=fxm
        b = x_middle;
        x_middle = x1;
        fxm = fx1;
        
    else 
        a = x1;
        b = x2;
end
fprintf('The intervals for iteration \n')
disp(a);
disp(b);
end  
fprintf(' the maxima lies between %d and %d \n ',a,b);
x_opt=(a+b)/2;
fprintf(' The X opt is %d \n ',x_opt);
fprintf(' The maximum value of the function is  %d  ',equation_func(x_opt));

