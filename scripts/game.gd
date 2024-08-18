extends Node2D

@onready var camera = $Camera2D
#@onready var viewport
@onready var spawn_area
@onready var debug_texture = $TextureRect
@onready var difficulty_factor = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_get_spawn_area()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_zoom_out(delta)

func _zoom_out(delta):
	_zoom_out_camera(delta)
	_expand_range(delta)
	_make_game_harder()

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

func _make_game_harder():
	var result = 0
	if camera.zoom.x < 0.8:
		result = 2
	if camera.zoom.x < 0.5:
		result = 4
	if camera.zoom.x < 0.3:
		result = 5
	difficulty_factor = result
