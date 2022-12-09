%%   Dichotomous Search 
% the value of tolerance is taken as 0.001 
clc; clearvars;
tol= 0.001;eps=tol/2; 
a=0;
b=3;
N = 8; % obtained from the equation as shown in the paper calculations 


 for i=1:N/2 % as each iteration as two experiments
    mid = (a+b)/2;
    a_new = mid-eps;       b_new = mid + eps;
    f_1 =equation_func(a_new);
    f_2 =equation_func(b_new);

    if f_1 > f_2            
        b = b_new; 
    elseif f_1<f_2                 
        a = a_new;
    end
   fprintf('Interval during iteration\n')
    disp(a);
    disp(b);
    fprintf('\n')
  end

fprintf(' the maxima lies between %d and %d \n ',a,b);
x_opt=(a+b)/2;
fprintf(' The X opt is %d \n ',x_opt);
fprintf(' The maximum value of the function is  %d  ',equation_func(x_opt));