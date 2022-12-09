function [y] = equation_func(lambda)
     y = 0.5./((1+(lambda).^2).^0.5) - ((1+ (lambda).^2).^0.5).*(1 - ((0.5)./(1+ (lambda).^2))) + lambda;
end