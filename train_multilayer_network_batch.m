function ans_net = train_multilayer_network_batch(net,patterns,err,g,g_der,learning_rate,b)

	expected_output = patterns(:,3);
	input = patterns(:,1:2);
	patterns_quantity = size(input)(1);
	layers_quantity = size(net)(2);

	iteration = 1;

	do 
		printf('iteration: %d\n',iteration);
		layer_in = input;
		for m=1:layers_quantity
			layer_out = g(b,([(ones(size(layer_in)(1),1)*(-1)) layer_in]*net{m}));
			V{m} = layer_out; 
			layer_in = layer_out;
		end

		delta{layers_quantity} = g_der(b,V{layers_quantity}).*(expected_output-V{layers_quantity});

		for m=layers_quantity:-1:2
			delta{m-1} = g_der(b,V{m-1}).*(delta{m}*(net{m}(2:end,:))');
			net{m} = net{m} + learning_rate(iteration)*[  ones(size(V{m-1})(1),1).*(-1) V{m-1}]'*delta{m};
		end

		net{1} = net{1} + learning_rate(iteration)*[ ones(size(input)(1),1).*(-1) input]'*delta{1};



		0.5*sum((expected_output-V{layers_quantity}).^2)
		fflush(stdout);

		iteration=iteration+1;

	until (0.5*sum((expected_output-V{layers_quantity}).^2)/patterns_quantity < err)


	ans_net = net;

end