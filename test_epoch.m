function test_epoch(learned_net,test_set,g,b,layers_quantity,epoch,training_set)
		expected_output = test_set(:,3);
		output = test(learned_net,test_set,g,b,layers_quantity);

		acuracy=(1-0.5*sum((expected_output-output).^2)/size(test_set)(1))*100;

		subplot(1,2,2);
		hold on
		plot_title = sprintf('Acuracy (%%) on Test Set vs. Number of iterations. Acuracy = %d',acuracy);
		title(plot_title);
		xlabel('Number of iterations');
		ylabel('Acuracy (%)');
		plot(epoch,acuracy);

		%Plot total set
		%expected_output = [test_set(:,3);training_set(:,3)];
		%output = test(learned_net,[test_set;training_set],g,b,layers_quantity);

		%subplot(1,3,3);
		%hold on
		%plot(epoch,(1-0.5*sum((expected_output-output).^2)/size([test_set;training_set])(1))*100);
end