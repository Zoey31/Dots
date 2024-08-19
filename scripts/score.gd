extends Node2D

@onready var weight = 0
@onready var score = 0
@onready var score_UI = $"../../SCORE"
@onready var weight_UI = $"../../WEIGHT"
@onready var weightbar_UI = $"../../WeightBar"
@onready var weightbar2_UI = $"../../WeightBar2"

# Called when the node enters the scene tree for the first time.
func _ready():
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_weights(number):
	weight += number
	print("New weight ", weight)

func add_score():
	score += 1
	
func update():
	score_UI.text = "[center][b][font size=80][color=GREEN] POINTS: " + str(score) + "[/color][/font][/b][/center]"
	
	var left_weight = max(70 - weight, 0)
	weight_UI.text = "[right][b][font size=80][color=RED]" + str(left_weight) + "[/color][/font][/b][/right]"
	weightbar_UI.value = left_weight
	print("Left", left_weight)
	weightbar_UI.modulate = Color.GREEN
	if left_weight < 35:
		weightbar_UI.modulate = Color.YELLOW
	if left_weight < 20:
		weightbar_UI.modulate = Color.RED
	
	weightbar2_UI.modulate = weightbar_UI.modulate
	weightbar2_UI.value = weightbar_UI.value
