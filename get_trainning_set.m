function [trainning_set test_set] = get_trainning_set(path)
	information_set = dlmread(path,'',1,0);

	information_set = information_set(randperm(size(information_set,1)),:);

	patterns_quantity = size(information_set)(1);

	trainning_set_size = ceil(patterns_quantity*2/3);

	trainning_set = information_set(1:trainning_set_size,:);
	test_set = information_set((trainning_set_size+1):patterns_quantity,:);
end