function plot_training_set(patterns,output)

    subplot(2,3,6);
    scatter3(patterns(:,1),patterns(:,2),output,'filled');
    title('trainning set');
	xlabel('x');
	ylabel('y');
	zlabel('z');
end
