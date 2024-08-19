extends Node2D

@onready var weight = 0
@onready var score = 0
@onready var score_UI = $"../../SCORE"
@onready var weight_UI = $"../../WEIGHT"

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
	score_UI.text = "[b][font size=80][color=GREEN]" + str(score) + "[/color][/font][/b]"
	
	var left_weight = max(70 - weight, 0)
	weight_UI.text = "[right][b][font size=80][color=RED]" + str(left_weight) + "[/color][/font][/b][/right]"
