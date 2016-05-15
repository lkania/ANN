function ans_net = train_multilayer_network_batch(net,patterns,err,g,g_der,learning_rate,b,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha)

	expected_output = patterns(:,3);
	input = patterns(:,1:2);
	patterns_quantity = size(input)(1);
	layers_quantity = size(net)(2);

	iteration = 1;
	delta_learning_rate = 0;
	delta_error = 0;
	tendency = 0; %1 == ascendent and -1 == descendent
	iterations_with_the_same_tendency = 0;
	previous_delta_error=0;

	if activate_momentum
		for i=1:1:layers_quantity
			size_layer = size(net{i});
			previous_delta{i}=zeros(size_layer(1),size_layer(2));
		end
	end

	do 
		printf('Iteration: %d\n',iteration);
		layer_in = input;
		for m=1:layers_quantity
			layer_out = g(b,([(ones(size(layer_in)(1),1)*(-1)) layer_in]*net{m}));
			V{m} = layer_out; 
			layer_in = layer_out;
		end

		delta{layers_quantity} = g_der(b,V{layers_quantity}).*(expected_output-V{layers_quantity});

		for m=layers_quantity:-1:2
			delta{m-1} = g_der(b,V{m-1}).*(delta{m}*(net{m}(2:end,:))');
			delta_weight = learning_rate(iteration)*[ones(size(V{m-1})(1),1).*(-1) V{m-1}]'*delta{m};
			net{m} = net{m} + delta_weight;

			if activate_momentum
				net{m} = net{m} + momentum_alpha .* previous_delta{m};
				previous_delta{m} = delta_weight + momentum_alpha .* previous_delta{m};
			end		

		end

		delta_weight = learning_rate(iteration)*[ ones(size(input)(1),1).*(-1) input]'*delta{1};

		net{1} = net{1} + delta_weight;

		if activate_momentum
			net{1} = net{1} + momentum_alpha .* previous_delta{1};
			previous_delta{1} = delta_weight + momentum_alpha .* previous_delta{1};
		end


		current_delta_error = 0.5*sum((expected_output-V{layers_quantity}).^2)/patterns_quantity;

		printf('Error: %d\n',current_delta_error);

		%%%Adaptative Learning Rate%%%

			if activate_learning_rate

				if iterations_with_the_same_tendency==0
					old_net = net;
				end

				diff_error = previous_delta_error - current_delta_error;

				if (diff_error<0 && tendency == 1) || (diff_error>0 && tendency ==-1)
					iterations_with_the_same_tendency=iterations_with_the_same_tendency+1;
				else
					iterations_with_the_same_tendency=0;
					tendency = (-1)*sign(diff_error);
				end

				if iterations_with_the_same_tendency==change_learning_rate_after_iterations
					if tendency == 1
						delta_learning_rate = delta_learning_rate - adaptative_learning_rate_b * (delta_learning_rate+learning_rate(iteration)); 
						net = old_net;
					end

					if tendency == -1
						delta_learning_rate = delta_learning_rate + adaptative_learning_rate_a;
					end

					iterations_with_the_same_tendency=0;
				end

				previous_delta_error = current_delta_error;

			end
			%%%


		fflush(stdout);

		iteration=iteration+1;

	until (current_delta_error < err)

	ans_net = net;

end