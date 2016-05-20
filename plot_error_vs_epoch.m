function plot_error_vs_epoch(current_delta_error,test_error,iteration)

	    subplot(2,3,1);
    	hold on
	    
	    plot_legend_training_error = sprintf('Train Error = %d',current_delta_error);
    	plot_legend_test_error = sprintf('Test Error = %d',test_error);
	
		plot_ans = plot(iteration,current_delta_error,iteration,test_error,'r');
    
    	h = legend(plot_ans,plot_legend_training_error,plot_legend_test_error);

 		title('Error vs. Epoch');
      	xlabel('Epoch');
	   	ylabel('Error');
end
