extends Node2D

@onready var timeout = 0.5
@onready var timer = $Timer
@onready var dot = preload("res://scenes/dot.tscn")
@onready var spawn_offset = 100

@onready var game = $".."
@onready var _debug_factor = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_spawn_pos():
	var max_size_x = game.spawn_area[0]
	var max_size_y = game.spawn_area[1]
	#print(max_size_x, max_size_y)
	var pos_x = randf_range(-max_size_x / 2 * 0.5, max_size_x / 2 * 0.5) 
	#if pos_x + spawn_offset > max_size_x:
		#pass
	#elif pos_x < spawn_offset:
		#pos_x += spawn_offset
	var pos_y = randf_range(-max_size_y / 2 * 0.5, max_size_y / 2 * 0.5)
	
	game.debug_texture.size = Vector2(max_size_x * 0.8, max_size_y * 0.8)
	game.debug_texture.position = Vector2(-max_size_x / 2 * 0.8, -max_size_y / 2 * 0.8)
	
	print(
		" X ", 
		Vector2(-max_size_x, max_size_x),
		" Y ",
		Vector2(-max_size_y, max_size_y), 
		" Curr ",
		Vector2(pos_x, pos_y)
		)
	return Vector2(pos_x, pos_y)

func _spawn_dot():
	var d = dot.instantiate()
	var pos = get_spawn_pos()
	#print(pos)
	d.position = pos
	d.max_level = game.difficulty_factor
	print("Max level for dot: ", game.difficulty_factor, " for zoom ", game.camera.zoom.x)
	add_child(d)
	#for level in d.levels:
		#level.color *= _debug_factor
	#_debug_factor -= 0.05

#func _spawn_dot():
	

func _on_timer_timeout():
	_spawn_dot()
