function init_xor_tanh

	train_func=@train_multilayer_network_batch
	g=@tanh_func;
	g_der=@tanh_func_derivate;
	b = 1;
	learning_rate = @constant_rate;
	paths = 'test_xor_tanh.txt';
	nodes_per_layer = [2,2,1]; 
	err = 10^-3;
	change_learning_rate_after_iterations = 5;
	adaptative_learning_rate_a = 0.05;
	adaptative_learning_rate_b = 0.5;
	activate_learning_rate = false;
	activate_momentum=false;
	momentum_alpha=0.5;
  activate_normalization=false;
  activate_regularization=false;
  regularization_parameter=0.1;
  error_type="square";

  execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err,train_func,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha,activate_normalization,activate_regularization, regularization_parameter,error_type);

end

%tanh saturates in -1 and 1, hence using -1 and 1 in the test is a good representation of the wanted values.

