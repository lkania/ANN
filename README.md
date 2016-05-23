Para ejecutar cualquier prueba solo es necesarío configurar los siguientes paramentros y llamar a la función execute.

	train_func=@train_multilayer_network_online | @train_multilayer_network_batch
	g=@logistic | @tanh_func
	g_der=@logistic_derivate | @tanh_func_derivate
	b = 1;
	learning_rate =@constant_rate | @decaying_rate
	paths = 'archivo_con_datos.txt';
	nodes_per_layer = Por ej. [2,20,20,1] indica una red con 2 nodos de input, dos capas ocultas con 20 neuronas cada una y un único nodo de output
	err = 10^-3 ; Se indica el error de corte utilizando el set de training
	change_learning_rate_after_iterations = 5; 
	adaptative_learning_rate_a = 0.05; Factor a del aprendizaje adaptativo
	adaptative_learning_rate_b = 0.5; Factor b del aprendizaje adaptativo
	activate_learning_rate = false; Activar|Desactivar aprendizaje adaptativo
	activate_momentum=false; Activar|Desactivar momentum
	momentum_alpha=0.4; volor del parametro alpha momentum
	activate_normalization=false; Activar|Desactivar normalización
	normalization_type="logistic" | "tanh" ; Indica el tipo de normalización que se quiere
  
  	activate_regularization=false; Activar|Desactivar reguralización
  	regularization_parameter=0.1; Valor del parametro de regularización
  	error_type="entropy" | "Square"; Indica el tipo de error que se quiere utilizar
  
	execute(nodes_per_layer,paths,g,g_der,learning_rate,b,err,train_func,activate_learning_rate,change_learning_rate_after_iterations,adaptative_learning_rate_a,adaptative_learning_rate_b,activate_momentum,momentum_alpha,activate_normalization,normalization_type,activate_regularization, regularization_parameter,error_type);
