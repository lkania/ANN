function ans_net = train_multilayer_network_online(net,patterns,err,g,g_der,learning_rate,b)

	expected_output = patterns(:,2);
	input = patterns(:,1:2);
	patterns_quantity = size(input)(1);
	layers_quantity = size(net)(2);

	iteration = 1;

	do 
		printf('iteration: %d\n',iteration);
		index = randperm(patterns_quantity);

		for k=1:patterns_quantity

			layer_in = input(index(k),:);
			for m=1:layers_quantity
				layer_out = g(b,([-1 layer_in]*net{m}));
				V{m}(index(k),:) = layer_out; 
				layer_in = layer_out;
			end

			delta{layers_quantity} = g_der(b,V{layers_quantity}(index(k),:)).*(expected_output(index(k),:)-V{layers_quantity}(index(k),:));

			for m=layers_quantity:-1:2
				delta{m-1} = g_der(b,V{m-1}(index(k),:)).*(delta{m}*(net{m}(2:end,:))');
				net{m} = net{m} + learning_rate(iteration)*[ -1 V{m-1}(vec(k),:)]'*delta{m};
			end

			net{1} = net{1} + learning_rate(iteration)*[ -1 input(index(k),:)]'*delta{1};

		end

		0.5*sum((expected_output-V{layers_quantity}).^2)
		fflush(stdout);

		iteration=iteration+1;

	until (0.5*sum((expected_output-V{layers_quantity}).^2)/patterns_quantity < err)


	ans_net = net;

end