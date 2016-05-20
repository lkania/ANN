function test_epoch(learned_net,test_set,g,b,layers_quantity,epoch,training_set)
		expected_output = test_set(:,3);
		output = test(learned_net,test_set,g,b,layers_quantity);


		subplot(2,3,1);
		hold on
    test_error=0.5*sum((expected_output-output).^2)/size(test_set)(1);
    plot_legend = sprintf('Test Error = %d',test_error);
		plot(epoch,test_error,'r');
    legend(plot_legend);
 
    
    
    
    
		%Plot total set
    if mod(epoch,1)==0
      expected_output = [test_set(:,3);training_set(:,3)];
      output = test(learned_net,[test_set;training_set],g,b,layers_quantity);

      %subplot(1,3,3);
      %hold on
      subplot(2,3,5);
      scatter3([test_set;training_set](:,1),[test_set;training_set](:,2),output,'filled');
      title('Learned function (trainning set + test set)'); 
     %plot(epoch,(1-0.5*sum((expected_output-output).^2)/size([test_set;training_set])(1))*100);
    endif
end