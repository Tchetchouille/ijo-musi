# This is partly based on code by chatGPT that was debugged and adapted to work here.
extends Area3D

@onready var main_cam : Camera3D = $"../../../.."
@onready var tool_cam : Camera3D = $"../../../../ToolViewport/ToolCamera"
@onready var hand : Node3D = $"../../../Hand"
@onready var tool_cam_front : Node3D = $"../../../../ToolViewport/ToolCamera/Tool_Camera_Front"
@onready var red_screen = $"../../../../../../ToolUI/RedMode"

var ray_length = 1000

var tool_mode

func _ready():
	tool_mode = "base"
	red_screen.visible = false
	red_screen.set_process(false)

# Detect clicks on tool screen
func _input(event):
	if tool_mode == "base":
		if event.is_action_pressed("click"):
			print(touch())

func touch():
	var target_params = {
		'mode' : null,
		'text' : 'If you read this something went wrong.'
	}
	var ray_to_screen_start = main_cam.global_position
	var ray_to_screen_direction = -(ray_to_screen_start - hand.global_position).normalized()
	var ray_to_screen_end = ray_to_screen_start + ray_to_screen_direction * ray_length
	var ray_to_screen = PhysicsRayQueryParameters3D.create(ray_to_screen_start, ray_to_screen_end)
	ray_to_screen.collide_with_areas = true
	ray_to_screen.collide_with_bodies = false
	var point_on_screen = get_world_3d().direct_space_state.intersect_ray(ray_to_screen)
	if not point_on_screen.is_empty():
		# ray properties
		var ray_to_obj_start = tool_cam.global_position
		var ray_to_obj_direction = point_on_screen["position"] + (tool_cam_front.global_position - ray_to_obj_start) * 0.45 - ray_to_obj_start
		var ray_to_obj_end = ray_to_obj_start + ray_to_obj_direction * 100
		# actually shooting the ray
		var ray_to_obj = PhysicsRayQueryParameters3D.create(ray_to_obj_start, ray_to_obj_end)
		ray_to_screen.collide_with_areas = false
		ray_to_screen.collide_with_bodies = true
		var obj = get_world_3d().direct_space_state.intersect_ray(ray_to_obj).collider
		# If there is an essence (which means the object is labeled), go to relevant screen mode
		
		if obj.get_node_or_null("RedGreenEssence"):
			var target = obj.get_node("RedGreenEssence")
			var r_or_g = target.g_r_state
			target_params.mode = r_or_g
			target_params.text = target.text[r_or_g]
			switch_mode('red')
		else:
			print(obj)
	return target_params

func switch_mode(mode):
	match mode:
		'red':
			tool_mode = 'red'
			red_screen.visible = true
			red_screen.set_process(true)
		'green':
			pass
		'blue':
			pass
		_:
			pass
