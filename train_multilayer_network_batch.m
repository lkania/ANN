function ans_net = train_multilayer_network_batch(net,patterns,err,g,g_der,learning_rate,b,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha,test_set,activate_regularization, regularization_parameter,error_type)

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
  previous_momentum_alpha=momentum_alpha;
  
  
  for i=1:1:layers_quantity
    size_layer = size(net{i});
    regularization{i}=zeros(size_layer(1),size_layer(2));
  end
	
	if activate_momentum
		for i=1:1:layers_quantity
			size_layer = size(net{i});
			previous_delta{i}=zeros(size_layer(1),size_layer(2));
		end
	end

	figure('Position',[50,50,1200,600]);
 
	plot_original_function(patterns,test_set);
  
	do 
		layer_in = input;
		for m=1:layers_quantity
			layer_out = g(b,([(ones(size(layer_in)(1),1)*(-1)) layer_in]*net{m}));
			V{m} = layer_out; 
			layer_in = layer_out;
		end

    switch (error_type)
      case "square"
  		  %Mean square error derivation
	    	delta{layers_quantity} = g_der(b,V{layers_quantity}).*(expected_output-V{layers_quantity})./patterns_quantity;
      case "entropy"
        %Entropy error derivation
        %If you use g=tanh, do not use entropy error because tanh could return -1 and generate a -1
        delta{layers_quantity} = V{layers_quantity}.*(1./(1+V{layers_quantity})).*(expected_output-V{layers_quantity})./patterns_quantity.*2.*b; 
     endswitch

		for m=layers_quantity:-1:2
			%Mean square error derivation | Entropy error derivation
			delta{m-1} = g_der(b,V{m-1}).*(delta{m}*(net{m}(2:end,:))');

			%Mean square error derivation + complexity
			%delta{m-1} = g_der(b,V{m-1}).*(delta{m}*(net{m}(2:end,:))') + 2.*abs(net{m}(2:end,:));

      if activate_regularization
     regularization{m}=(regularization_parameter./patterns_quantity-1./(learning_rate(iteration)+delta_learning_rate)).*net{m};
     regularization{m}(1,:)=zeros(1,size(regularization{m})(2));
     endif
			delta_weight = (learning_rate(iteration)+delta_learning_rate)*([ones(size(V{m-1})(1),1).*(-1) V{m-1}]'*delta{m}+regularization{m});
			net{m} = net{m} + delta_weight;

			if activate_momentum
				net{m} = net{m} + momentum_alpha .* previous_delta{m};
				previous_delta{m} = delta_weight + momentum_alpha .* previous_delta{m};
			end		

		end

		delta_weight = (learning_rate(iteration)+delta_learning_rate)*[ ones(size(input)(1),1).*(-1) input]'*delta{1};

		net{1} = net{1} + delta_weight;

		if activate_momentum
			net{1} = net{1} + momentum_alpha .* previous_delta{1};
			previous_delta{1} = delta_weight + momentum_alpha .* previous_delta{1};
		end

	output = test(net, patterns, g, b, layers_quantity);


    switch (error_type)
    	case "square"
        	%Mean square error
        	current_delta_error = 0.5*sum((expected_output-output).^2)/patterns_quantity;

       	case "entropy"
       		%Entropy error
        	partial_error_1=(1.-expected_output).*log((1.-expected_output)./(1-output));
        	partial_error_1(~isfinite(partial_error_1))=0;
        	partial_error_2=(1+expected_output).*log((1+expected_output)./(1+output));
        	partial_error_2(~isfinite(partial_error_2))=0;
        	current_delta_error = 0.5.*sum(partial_error_2+partial_error_1)./patterns_quantity;

	endswitch


    if activate_regularization
      accumulated=0;
      for m=1:layers_quantity
        accumulated=accumulated+sum(sum(net{m}(2:end,:).**2));
      end
      current_delta_error=current_delta_error+regularization_parameter.*0.5.*(1./patterns_quantity).*accumulated;
    endif

		%%%Adaptative Learning Rate%%%

			if activate_learning_rate

				if iterations_with_the_same_tendency==0
					old_net = net;
				end

			   	round_rate=(err.**(-1)).*10;
          		diff_error = round(previous_delta_error.*round_rate)./round_rate - round(current_delta_error.*round_rate)./round_rate;

				if (diff_error<0 && tendency == 1) || (diff_error>=0 && tendency ==-1)
					iterations_with_the_same_tendency=iterations_with_the_same_tendency+1;
				else
					iterations_with_the_same_tendency=0;
					tendency = (-1)*sign(diff_error);
				end

				if iterations_with_the_same_tendency==change_learning_rate_after_iterations
					if tendency == 1
						delta_learning_rate = (-1).* adaptative_learning_rate_b * (learning_rate(iteration)); 
						net = old_net;
            			momentum_alpha=0;
					end

					if tendency == -1
						delta_learning_rate =  adaptative_learning_rate_a;
            			momentum_alpha=previous_momentum_alpha;
					end

					iterations_with_the_same_tendency=0;
				end

				previous_delta_error = current_delta_error;

			end
		%%%


		fflush(stdout);

		iteration=iteration+1;

    if mod(iteration,100)==0
    
      	test_error = test_epoch(net,test_set,g,b,layers_quantity,iteration,patterns);

      	plot_error_vs_epoch(current_delta_error,test_error,iteration);
 
 		plot_learning_rate_vs_epoch(learning_rate(iteration)+delta_learning_rate,iteration);

 		plot_training_set(patterns,output);

 		drawnow;

    endif
    
	until (current_delta_error < err)

	ans_net = net;

end