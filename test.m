function test(learned_net,test_set,g,b,layers_quantity)
		input = test_set(:,1:2);
		expected_output = test_set(:,3);

		layer_in = input;
		for m=1:layers_quantity
			layer_out = g(b,([(ones(size(layer_in)(1),1)*(-1)) layer_in]*learned_net{m}));
			V{m} = layer_out;
			layer_in = layer_out;
		end

		printf('Test Error: %d\n',0.5*sum((expected_output-layer_in).^2)/size(test_set)(1));

		abs(layer_in-expected_output)

end