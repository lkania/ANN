function init_xor_logistic

g=@logistic;
g_der=@logistic_derivate;
b = 1;
learning_rate = @decaying_rate;
paths = 'test.txt';
nodes_per_layer = [2,2,1]; 
err = 10^-2;
execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err);


end