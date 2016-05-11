function execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err)

	net = initialize_mutilayer_network(nodes_per_layer);

	[trainning_set test_set] = get_trainning_set(paths);

	learned_net = train_multilayer_network_batch(net,trainning_set,err,g,g_der,learning_rate,b)

	test(learned_net,test_set,g,b,size(nodes_per_layer)(2)-1);

end