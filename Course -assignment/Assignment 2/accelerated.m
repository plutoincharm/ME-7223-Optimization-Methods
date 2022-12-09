%Accelerated unrestricted search 
clc; clearvars;
lambda= [0:0.1:3];
inc=0;% initial guess 0.0
i=0.1;
x_opt=0;
while 1
    if (inc==0)&&(equation_func(inc) > equation_func(inc+i))
        break
    elseif (inc==0)&&(equation_func(inc) < equation_func(inc+i))
        inc=0.1;
        continue
    end

    if (equation_func(inc) > equation_func(inc+i))&&(inc<=3)
        break
    end
    inc = inc + i;
    i=i*2;
end

%inc=inc-1;
max_val= equation_func(inc);
x_opt=inc;
fprintf(' maximum value  = %d.\n',max_val);
fprintf('Point of maximum  x* = %d.\n',x_opt);

 

