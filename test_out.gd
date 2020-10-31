extends Node

var NeuralNetwork = load('res://NeuralNetwork.gd')

func _ready() -> void:
    var nn = NeuralNetwork.new(2, 4, 1)
    var input = [0, 1]
    var target = [0]
    for i in range(10000):
        nn.train(input, target)
        print(nn.weights_ih)
    print(nn.predict([1, 1]))


# onready var nn = NeuralNetwork.new(2, 4, 1)
# onready var input = [0, 1]
# onready var target = [0]

# func _process(delta: float) -> void:
#     nn.train(input, target)