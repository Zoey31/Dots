extends Node2D

@onready var camera = $Camera2D
#@onready var viewport
@onready var spawn_area
@onready var debug_texture = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	_get_spawn_area()
	#print("MAX / MIN", camera.get_viewport_rect().size)
	#camera.position = Vector2(
		#camera.get_viewport_rect().size[0] / 2, 
		#camera.get_viewport_rect().size[1] / 2
		#)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_zoom_out(delta)

func _zoom_out(delta):
	_zoom_out_camera(delta)
	_expand_range(delta)

func _zoom_out_camera(delta):
	# TODO check setzoom
	camera.zoom -= 0.05 * camera.zoom * delta

func _get_spawn_area():
	spawn_area = Vector2(
		camera.get_viewport_rect().size[0] / camera.zoom.x,
		camera.get_viewport_rect().size[1] / camera.zoom.y
		)

func _expand_range(delta):
	_get_spawn_area()

