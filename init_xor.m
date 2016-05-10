function init_xor

g=@tanh_func;
g_der=@tanh_func_derivate;
b = 1;
learning_rate = @constant_rate;
paths = 'test.txt';
nodes_per_layer = [2,2,1]; 
err = 10^-3;
execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err);


end