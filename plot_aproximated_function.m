function plot_aproximated_function(test_set,training_set,g,b,layers_quantity,learned_net)
    
    expected_output = [test_set(:,3);training_set(:,3)];
    output = test(learned_net,[test_set;training_set],g,b,layers_quantity);

    subplot(2,3,5);
    scatter3([test_set;training_set](:,1),[test_set;training_set](:,2),output,'filled');
    title('Learned function (trainning set + test set)'); 
   	xlabel('x');
	ylabel('y');
	zlabel('z');
end