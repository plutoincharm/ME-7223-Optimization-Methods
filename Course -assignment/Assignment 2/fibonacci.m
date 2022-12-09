%%  Fibonacci Method 
%  a and b are the upper bound and lower bound of search space 
%  equation_func is the name of the function 
%  x1 and x2 are the lower and upper bound 

clc; clearvars;
a=0;b=3;
%k=2;
n=10;                                                                      
N=n+1;

f_prev=1;
f_succ=1; 
for k=1:N
    if k==1 || k==2
        f(k)=1;
        continue;
    end
    f(k)=f_prev+f_succ;
    f_prev=f_succ;
    f_succ=f(k);
end

L2=(b-a)*f(N-2)/f(N);
j=2;
while j<N
fprintf('The intervals for iteration \n')    
disp(a);
disp(b);  
L1=(b-a);
if L2>L1/2
    anew=b-L2;
    bnew=a+L2;
elseif L2<=L1/2
        anew=a+L2;
        bnew=b-L2;
   % end
end
f_1=equation_func(anew);
f_2=equation_func(bnew);
if f_2>f_1
    a=anew;
    L2=f(N-j)*L1/f(N-j+2);
elseif f_2<f_1
        b=bnew;
        L2=f(N-j)*L1/f(N-(j-2));
elseif f_2==f_1
            %a=anew;
            b=bnew;
            L2=f(N-j)*[b-a]/f(N-(j-2));
            j=j+1;
 end
 %   end
%end
j=j+1;
end
fprintf(' the maxima lies between %d and %d \n ',a,b);
x_opt=(a+b)/2;
fprintf(' The X opt is %d \n ',x_opt);
fprintf(' The maximum value of the function is  %d  ',equation_func(x_opt));

