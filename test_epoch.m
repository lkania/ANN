function test_error = test_epoch(learned_net,test_set,g,b,layers_quantity,epoch,training_set)
	expected_output = test_set(:,3);
	output = test(learned_net,test_set,g,b,layers_quantity);

  test_error=0.5*sum((expected_output-output).^2)/size(test_set)(1);

  plot_aproximated_function(test_set,training_set,g,b,layers_quantity,learned_net);
end