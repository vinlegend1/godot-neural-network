class Matrix:
	var rows
	var cols
	var data = []

	func _init(numRows, numCols):
		self.rows = numRows
		self.cols = numCols
		for x in range(rows):
			self.data.append([])
			for y in range(cols):
				self.data[x].append(0)
		
	# Make a new copy with the same "properties"
	func copy():
		var m = Matrix.new(self.rows, self.cols)
		for i in range(self.rows):
			for j in range(self.cols):
				m.data[i][j] = self.data[i][j]
		return m
		
	static func fromArray(arr):
		var m = Matrix.new(arr.size(), 1)
		for i in range(arr.size()):
			m.data[i][0] = arr[i]
		return m
		
	func toArray():
		var arr = []
		for i in range(self.rows):
			for j in range(self.cols):
				arr.append(self.data[i][j])
		return arr

	# subtract
	static func subtract(a: Matrix, b: Matrix):
		if a.rows != b.rows || a.cols != b.cols:
			print('Columns and Rows of A must match Columns and Rows of B.')
		
		var result = Matrix.new(a.rows, a.cols)	
		for i in range(result.rows):
			for j in range(result.cols):
				result.data[i][j] = a.data[i][j] - b.data[i][j]
		return result
			
	func randomizeIt():
		for x in range(rows):
			self.data.append([])
			for y in range(cols):
				self.data[x].append(rand_range(-1, 1))
				
	func add(n):
		if n is Matrix:
			if self.rows != n.rows || self.cols != n.cols:
				print('Columns and Rows of A must match Columns and Rows of B.')
				return
			for i in range(self.rows):
				for j in range(self.cols):
					self.data[i][j] += n.data[i][j]
		else:
			for i in range(self.rows):
				for j in range(self.cols):
					self.data[i][j] += n

	static func transpose(matrix):
		var result = Matrix.new(matrix.cols, matrix.rows)
		for i in range(matrix.rows):
			for j in range(matrix.cols):
				result.data[j][i] = matrix.data[i][j]
		return result

	static func multiply(a, b):
		if a.cols != b.rows:
			print('Columns of A must match rows of B.')
			return null
		var result = Matrix.new(a.rows, b.cols)
		for i in range(result.rows):
			for j in range(result.cols):
				var sum = 0
				for k in range(a.cols):
					sum += a.data[i][k] * b.data[k][j]
				result.data[i][j] = sum
		return result

	func mult(n):
		if n is Matrix:
			if self.rows != n.rows || self.cols != n.cols:
				print('Columns and Rows of A must match Columns and Rows of B.')
				return
			
			for i in range(self.rows):
				for j in range(self.cols):
					# print(self.data, n.data)
					self.data[i][j] *= n.data[i][j]
		else:
			for i in range(self.rows):
				for j in range(self.cols):
					self.data[i][j] *= n
		
	func printIt():
		print(self.data)

		
class_name NeuralNetwork


var input_nodes
var hidden_nodes
var output_nodes

var weights_ih
var weights_ho

var bias_h
var bias_o

var learning_rate

func _sigmoid(x):
	return 1 / (1 + exp(-x))
	pass

func _d_sigmoid(x):
	return self._sigmoid(x) * (1 - self._sigmoid(x))
	pass

func _init(in_nodes, hid_nodes, out_nodes):
	
	self.input_nodes = in_nodes
	self.hidden_nodes = hid_nodes
	self.output_nodes = out_nodes
	
	self.weights_ih = Matrix.new(self.hidden_nodes, self.input_nodes)
	self.weights_ho = Matrix.new(self.output_nodes, self.hidden_nodes)
	self.weights_ih.randomizeIt()
	self.weights_ho.randomizeIt()

	self.bias_h = Matrix.new(self.hidden_nodes, 1)
	self.bias_o = Matrix.new(self.output_nodes, 1)
	self.bias_h.randomizeIt()
	self.bias_o.randomizeIt()
	
	self.setLearningRate()
	

func predict(input_array):
	var inputs = Matrix.fromArray(input_array);
	var hidden = Matrix.multiply(self.weights_ih, inputs)
	hidden.add(self.bias_h)
	
	for i in range(hidden.rows):
		for j in range(hidden.cols):
			hidden.data[i][j] = self._sigmoid(hidden.data[i][j])
	
	var output = Matrix.multiply(self.weights_ho, hidden)
	output.add(self.bias_o)

	for i in range(output.rows):
		for j in range(output.cols):
			output.data[i][j] = self._sigmoid(output.data[i][j])

	return output.toArray()

func train(input_array, target_array):
	var inputs = Matrix.fromArray(input_array);
	# print(inputs.data, "inputs")

	var hidden = Matrix.multiply(self.weights_ih, inputs)
	hidden.add(self.bias_h)
	
	for i in range(hidden.rows):
		for j in range(hidden.cols):
			hidden.data[i][j] = self._sigmoid(hidden.data[i][j])
	
	var output = Matrix.multiply(self.weights_ho, hidden)
	output.add(self.bias_o)

	for i in range(output.rows):
		for j in range(output.cols):
			output.data[i][j] = self._sigmoid(output.data[i][j])

	var targets = Matrix.fromArray(target_array)

	var output_errors = Matrix.subtract(targets, output)
	# print(output_errors.data, "output_errors")

	var gradients_arr = []

	for i in range(output.rows):
		for j in range(output.cols):
			gradients_arr.append(self._d_sigmoid(output.data[i][j]))
			# print(gradients_arr)
	
	# print(gradients_arr, "gradients_arr")
	
	var gradients = Matrix.fromArray(gradients_arr)
	# print(gradients.data, "gradients")
	gradients.mult(output_errors)
	gradients.mult(self.learning_rate)

	var hidden_T = Matrix.transpose(hidden)
	var weights_ho_delta = Matrix.multiply(gradients, hidden_T)

	self.weights_ho.add(weights_ho_delta)
	self.bias_o.add(gradients)

	var who_T = Matrix.transpose(self.weights_ho)
	var hidden_errors = Matrix.multiply(who_T, output_errors)

	var hidden_arr = []
	for i in range(hidden.rows):
		for j in range(hidden.cols):
			hidden_arr.append(self._d_sigmoid(hidden.data[i][j]))

	var hidden_gradient = Matrix.fromArray(hidden_arr)

	hidden_gradient.mult(hidden_errors)
	hidden_gradient.mult(self.learning_rate)

	var inputs_T = Matrix.transpose(inputs)
	var weight_ih_deltas = Matrix.multiply(hidden_gradient, inputs_T)

	self.weights_ih.add(weight_ih_deltas)
	self.bias_h.add(hidden_gradient)


func setLearningRate(learn_rate = 0.24) -> void:
	self.learning_rate = learn_rate

# func copy():
# 	return NeuralNetwork.new(self.input_nodes, self.hidden_nodes, self.output_nodes)
