function y = tanh_func_derivate(b,x)
	y = b.*(1-tanh_func(b,x).^2);
end