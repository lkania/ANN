function plot_learning_rate_vs_epoch(learning_rate,iteration)

    subplot(2,3,2);
    hold on
    plot_ans = plot(iteration,learning_rate);

    plot_legend = sprintf('Learning rate = %d',learning_rate);

	h = legend(plot_ans,plot_legend);

    title('Learning rate vs. Epoch');
   	xlabel('Epoch');
  	ylabel('Learning rate');
endfunction
