extends Node2D

@onready var camera = $Camera2D
@onready var game_area: Node2D = $GameArea
@onready var score = $GameArea/Score

@onready var spawn_area
@onready var debug_texture = $TextureRect
@onready var difficulty_factor = 0

@onready var UI = $"GAME OVER"
@onready var score_UI = $"SCORE"
@onready var weight_UI = $"WEIGHT"
@onready var bg = $Background

# Called when the node enters the scene tree for the first time.
func _ready():
	UI.visible = false
	_get_spawn_area()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_zoom_out(delta)

func _zoom_out(delta):
	_check_wincon()
	_zoom_out_camera(delta)
	_expand_range(delta)
	_make_game_harder()
	_scale_UI()

func _zoom_out_camera(delta):
	# TODO check setzoom
	#camera.zoom -= camera.zoom * 0.05 * delta

	game_area.scale -= game_area.scale * 0.05 * delta

	
func _scale_UI():
	var viewportRect = camera.get_viewport_rect()
	var vewportSize = Vector2(viewportRect.size[0], viewportRect.size[1])
	UI.scale = Vector2(1, 1) / camera.zoom
	UI.global_position = Vector2(-UI.scale.x * UI.size.x/2, -vewportSize.y/2)
	
	score_UI.scale = Vector2(1, 1) / camera.zoom
	score_UI.global_position = Vector2(-vewportSize.x/2, -vewportSize.y/2)
	
	weight_UI.scale = Vector2(1, 1) / camera.zoom
	weight_UI.global_position = Vector2(vewportSize.x/2 - weight_UI.scale.x * weight_UI.size.x, -vewportSize.y/2)
	
	#bg.scale = Vector2(game_area.scale.x, game_area.scale.y)
	#bg.global_position = Vector2(-vewportSize.x/2, -vewportSize.y/2)
	#print("CALC ", Vector2(1.0, 1.0) / camera.zoom, "BG ", bg.scale)
	

func _get_spawn_area():
	spawn_area = Vector2(
		camera.get_viewport_rect().size[0] / game_area.scale.x,
		camera.get_viewport_rect().size[1] / game_area.scale.y
		)

func _expand_range(delta):
	_get_spawn_area()

func _check_wincon():
	if score.weight >= 70:
		game_over()
		
func game_over():
	UI.visible = true
	score.update()
	get_tree().paused = true

func _make_game_harder():
	var result = 0
	if game_area.scale.x < 0.8:
		result = 1
	if game_area.scale.x < 0.65:
		result = 2
	if game_area.scale.x < 0.5:
		result = 3
	if game_area.scale.x < 0.3:
		result = 4
	if game_area.scale.x < 0.2:
		result = 5
	if game_area.scale.x < 0.1:
		result = 6
	if game_area.scale.x < 0.05:
		result = 7
	if game_area.scale.x < 0.01:
		result = 8
	difficulty_factor = result
