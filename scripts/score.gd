extends Node2D

@onready var weight = 0
@onready var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_weights(number):
	weight += number
	print("New weight ", weight)

func add_score():
	score += 1
