function init_terrain

	train_func=@train_multilayer_network_batch
	g=@tanh_func;@logistic;%@logistic;%@tanh_func;
	g_der=@tanh_func_derivate;%@logistic_derivate;%tanh_func_derivate;
	b = 1;
	learning_rate = @decaying_rate;%@decaying_rate;%@constant_rate;
	paths = 'terrain.txt';
	nodes_per_layer = [2,5,1]; 
	err = 10^-3;
	change_learning_rate_after_iterations = 5;
	adaptative_learning_rate_a = 0.05;
	adaptative_learning_rate_b = 0.5;
	activate_learning_rate = true;
	activate_momentum=true;
	momentum_alpha=0.4;

	execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err,train_func,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha);

end