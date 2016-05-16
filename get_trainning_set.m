function [trainning_set test_set] = get_trainning_set(path,activate_normalization)
	information_set = dlmread(path,'',1,0);

	information_set = information_set(randperm(size(information_set,1)),:);


	if(activate_normalization)
		information_set(:,1) = ((information_set(:,1)-min(information_set(:,1)))./(max(information_set(:,1))-min(information_set(:,1)))).*1;
		information_set(:,2) = ((information_set(:,2)-min(information_set(:,2)))./(max(information_set(:,2))-min(information_set(:,2)))).*1;
		information_set(:,3) = ((information_set(:,3)-min(information_set(:,3)))./(max(information_set(:,3))-min(information_set(:,3)))).*1;
	end


	patterns_quantity = size(information_set)(1);

	trainning_set_size = ceil(patterns_quantity*1/3);

	trainning_set = information_set(1:trainning_set_size,:);
	test_set = information_set((trainning_set_size+1):patterns_quantity,:);
end