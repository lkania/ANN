function y = logistic_derivate(b,x)

	y = logistic(b,x).*(1-logistic(b,x));

end