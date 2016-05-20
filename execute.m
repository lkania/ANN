function execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err,train_function,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha,activate_normalization,normalization_type,activate_regularization, regularization_parameter,error_type)

	net = initialize_mutilayer_network(nodes_per_layer);

	[trainning_set test_set] = get_trainning_set(paths,activate_normalization,normalization_type);

	learned_net = train_function(net,trainning_set,err,g,g_der,learning_rate,b,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha,test_set,activate_regularization, regularization_parameter,error_type)

	test(learned_net,test_set,g,b,size(nodes_per_layer)(2)-1);

end