extends Node2D

class Level:
	var color: Color
	var points: int
	var scale_multiplier: Vector2

@onready var sprite = $Sprite2D

var curr_level = -1
@onready var curr_points = 1
@onready var levels = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	if curr_level == -1:
		curr_level = 2
	_set_default_levels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_characteristics(curr_level)

func _set_default_levels():
	levels.append_array([
		_create_level(Color.BLACK, 1, Vector2(0.1, 0.1)),
		_create_level(Color.YELLOW, 2, Vector2(0.2, 0.2)),
		_create_level(Color.ORANGE, 4, Vector2(0.4, 0.4))
	])
	
func _set_characteristics(level):
	sprite.modulate = levels[level].color
	curr_points = levels[level].points
	sprite.scale = levels[level].scale_multiplier

func _create_level(color, points, scale_multiplier):
	var l = Level.new()
	l.color = color
	l.points = points
	l.scale_multiplier = scale_multiplier
	return l

func reduce_level():
	if curr_level > -1:
		curr_level -= 1
	if curr_level == -1:
		queue_free()
