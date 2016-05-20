function [training_set test_set] = get_trainning_set(path,activate_normalization,normalization_type)
	information_set = dlmread(path,'',1,0);

	information_set = information_set(randperm(size(information_set,1)),:);

  
  
	if(activate_normalization)
    switch normalization_type
      case "tanh"
        for k=1:1:3 
          information_set(:,k) = ((information_set(:,k)-mean(information_set(:,k)))./(max(information_set(:,k))-min(information_set(:,k))));
		    endfor
      case "logistic" 
        for k=1:1:3 
          information_set(:,k) = ((information_set(:,k)-min(information_set(:,k)))./(max(information_set(:,k))-min(information_set(:,k))));
		    endfor
    end
	end

	patterns_quantity = size(information_set)(1);

	training_set_size = ceil(patterns_quantity*1/16);

	training_set = information_set(1:training_set_size,:);
	test_set = information_set((training_set_size+1):patterns_quantity,:);

	printf("Training Set Size: %d\n",size(training_set)(1));
	printf("Test Set Size: %d\n",size(test_set)(1));
end