function [trainning_set test_set] = get_trainning_set(path)
	 information_set = dlmread(path,' ',1,0);

	 trainning_set = information_set;
	 test_set = information_set;
end