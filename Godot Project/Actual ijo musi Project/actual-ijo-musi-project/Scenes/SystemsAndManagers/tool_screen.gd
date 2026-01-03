# This is partly based on code by chatGPT that was debugged and adapted to work here.
extends Area3D

@onready var main_cam : Camera3D = $"../../../.."
@onready var tool_cam : Camera3D = $"../../../../ToolViewport/ToolCamera"
@onready var hand : Node3D = $"../../../Hand"
@onready var local_ref : Node3D = $"../../../../../LocalReference"

var ray_length = 1000

# Detect clicks on tool screen
func _input(event):
	# Step 1 shoot a ray from the main camera to the hand
	if event.is_action_pressed("click"):
		var ray_to_screen_start = main_cam.global_position
		var ray_to_screen_direction = -(ray_to_screen_start - hand.global_position).normalized()
		var ray_to_screen_end = ray_to_screen_start + ray_to_screen_direction * ray_length
		var ray_to_screen = PhysicsRayQueryParameters3D.create(ray_to_screen_start, ray_to_screen_end)
		ray_to_screen.collide_with_areas = true
		ray_to_screen.collide_with_bodies = false
		var point_on_screen = get_world_3d().direct_space_state.intersect_ray(ray_to_screen)
		var old_vector = point_on_screen["position"] - tool_cam.global_position
		
		REREAD THIS : https://en.wikipedia.org/wiki/Vector_projection
		# project vector on the coordinates of the "screen space"
		# since I have defined local_ref to have coordinates vectors of norm 1, the formula is simple:
		print(old_vector)
		print(local_ref.get_child(0).global_position - tool_cam.global_position)
		var new_x = old_vector.dot(local_ref.get_child(0).global_position - tool_cam.global_position)
		var new_y = old_vector.dot(local_ref.get_child(1).global_position - tool_cam.global_position)
		var new_z = old_vector.dot(local_ref.get_child(2).global_position - tool_cam.global_position)
		# Then I can apply my transformation to these new vectors
		var fov_ratio = main_cam.fov / tool_cam.fov
		new_x = new_x * fov_ratio
		new_y = new_y * fov_ratio
		# And finally use them to calculate the new vector
		var new_vector = new_x + new_y + new_z
		

		# And now we can finally cast a ray from the tool to see if there is an object on its path
		var ray_to_obj_start = tool_cam.global_position
		var ray_to_obj_direction = (ray_to_obj_start + new_vector).normalized()
		var ray_to_obj_end = ray_to_obj_direction * ray_length
		var ray_to_obj = PhysicsRayQueryParameters3D.create(ray_to_obj_start, ray_to_obj_end)
		ray_to_obj.collide_with_areas = false
		ray_to_obj.collide_with_bodies = true
		var hit = get_world_3d().direct_space_state.intersect_ray(ray_to_obj)
		# debug
		var test_scene = load("res://Scenes/Objects/Furniture/basic_lamp.tscn")
		var instance = test_scene.instantiate()
		$"../../../../../../..".add_child(instance)
		instance.global_position = ray_to_obj_direction
