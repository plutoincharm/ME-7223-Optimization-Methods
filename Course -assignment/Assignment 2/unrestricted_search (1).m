%unrestricted search 
clc; clearvars;
lambda= [0:0.1:3];
inc=0;% initial guess 0.0
i=1;
x_opt=0;
while 1

    if (equation_func(inc)==equation_func(inc+0.1))&&(inc<=3)
            x_opt= (2*inc+1)/2;

    elseif (equation_func(inc) > equation_func(inc+0.1))&&(inc<=3)
        break
    end
    inc = inc + 0.1;
    %i=i+1;
end

%inc=inc-1;
max_val= equation_func(inc);
x_opt=inc;
fprintf(' maximum value  = %d.\n',max_val);
fprintf('Point of maximum  x* = %d.\n',x_opt);

 

