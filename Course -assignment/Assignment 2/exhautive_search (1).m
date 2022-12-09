%Exhaustive search
% interval (0,3)
% 5% accuracy
%

clc; clearvars;
N = 100/5-1;% so N should be more than 19
N=20;% as N can be more than 19 , lets take N = 20
a=0;% initail limit
b=3;% upper limit
Del=(b-a)/N;
inc=0;
%Now we exhaustively find the vcalues for 19 experiments by a step difference of Del
for i=1:N
    f(i)=equation_func(Del*(i-1));
end

[max_val,I] = max(f);
final_interval_lower_limit = Del*(I-2)% we minus 2 as we consider the function with initial zero value
final_interval_upper_limit = Del*(I)
x_opt=(final_interval_lower_limit + final_interval_upper_limit)/2;
fprintf(' maximum value  = %d.\n',max_val);
fprintf('Point of maximum  x* = %d.\n',x_opt);
%max_val = equation_func(x_opt);
 

