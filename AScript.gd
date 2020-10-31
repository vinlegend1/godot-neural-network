extends Node2D


var NeuralNetwork = load('res://NeuralNetwork.gd')

# it works!!! (I think)
func _ready() -> void:
	var nn = NeuralNetwork.new(2, 4, 1)
	var input
	var target
	for i in range(5000):
		if rand_range(0, 4) > 3:
			# print('>3')
			input = [0, 1]
			target = [1]
		elif rand_range(0, 4) > 2:
			# print('>2')
			input = [1, 1]
			target = [0]
			
		elif rand_range(0, 4) > 1:
			# print('>1')

			input = [0, 0]
			target = [0]
		elif rand_range(0, 4) > 0:
			# print('>0')
			input = [1, 0]
			target = [1]
			
		nn.train(input, target)

	var prediction = nn.predict([0, 0])
	if prediction[0] > 0.5:
		print(prediction)
		print("1")
	else:
		print(prediction)
		print("0")
	# print(nn.predict([1, 0]))
