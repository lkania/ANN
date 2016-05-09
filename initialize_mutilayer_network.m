function net = initialize_mutilayer_network(nodes_per_layer)

	range_max = 0.5;
	range_min = 0.000001;

	layers_quantity = size(nodes_per_layer)(2);
	for layer=1:(layers_quantity-1)
		random_matrix = rand(nodes_per_layer(layer)+1,nodes_per_layer(layer+1));
		random_matrix = ((random_matrix < 0.5).*2).-1;
		net{layer} = rand(nodes_per_layer(layer)+1,nodes_per_layer(layer+1))*(range_max-range_min).*random_matrix+range_min;
	end

end