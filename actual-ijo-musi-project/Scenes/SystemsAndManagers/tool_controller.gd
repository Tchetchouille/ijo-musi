extends Node3D

@onready var game_manager : Node = $"../../../../GameManager"

@export var sensitivity = 10

func _input(event):
	if game_manager.tool_out == true:
		# I the mouse is moved, we rotate do 2 things
		if event is InputEventMouseMotion:
			$Hand.transform.origin.x += event.relative.x / 100000 * sensitivity
			$Hand.transform.origin.y -= event.relative.y / 100000 * sensitivity
