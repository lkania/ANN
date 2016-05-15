function init_xor_logistic

	train_func=@train_multilayer_network_batch
	g=@logistic;
	g_der=@logistic_derivate;
	b = 1;
	learning_rate = @decaying_rate;
	paths = 'test_xor_logistic.txt';
	nodes_per_layer = [2,2,1]; 
	err = 10^-3;
	change_learning_rate_after_iterations = 5;
	adaptative_learning_rate_a = 0.05;
	adaptative_learning_rate_b = 0.5;
	activate_learning_rate = true;
	activate_momentum=true;
	momentum_alpha=0.5;

	execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err,train_func,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha);

end