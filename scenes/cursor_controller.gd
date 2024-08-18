extends CollisionShape2D

@onready var colition_list = Array()
@onready var blocked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()

func _on_area_2d_area_entered(area):
	blocked = false
	print("on enter ", area)
	if area == self:
		return

	if area in colition_list:
		return

	colition_list.append(area)
	print(colition_list)

func _on_area_2d_area_exited(area):
	blocked = false
	print("on exit ", area)
	if area == self:
		return

	if not area in colition_list:
		return

	colition_list.erase(area)
	print(colition_list)
	
func _get_closest():
	var mouse_pos = get_global_mouse_position()
	var tiny_pos = colition_list[0].global_position.distance_to(mouse_pos)
	var result = colition_list[0]
	for area in colition_list:
		var dist = area.global_position.distance_to(mouse_pos)
		if tiny_pos > dist:
			tiny_pos = dist
			result = area
	print(result)
	return result

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		if colition_list.is_empty():
			return
			
		#if blocked:
			#return
		#
		#blocked = true
		
		# first area found
		_get_closest()
		var dot_area = colition_list[-1]
		var dot = dot_area.get_node("../..")
		var dot_clone = dot.duplicate()
		dot.reduce_level()
		var level = dot.curr_level
		dot.queue_free()
		if level < 0:
			return
		dot_clone.curr_level = level
		$"../../Spawner".add_child(dot_clone)

