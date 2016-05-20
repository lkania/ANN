function plot_original_function(patterns,test_set)

	subplot(2,3,4);
	scatter3([patterns;test_set](:,1),[patterns;test_set](:,2),[patterns;test_set](:,3),'filled');
	title('Original function');
	xlabel('x');
	ylabel('y');
	zlabel('z');

end