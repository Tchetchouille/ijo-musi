extends Node

@export var tool_out = false

# Handling our custom inputs (I think that's the way to do it?)
func _input(event):
	# Right now escape quits.
	# Ultimately it should open the pause menu.
	if event.is_action_pressed("escape"):
		get_tree().quit()
