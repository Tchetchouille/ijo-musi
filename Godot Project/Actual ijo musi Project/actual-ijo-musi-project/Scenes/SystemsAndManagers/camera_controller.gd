extends Node3D

@onready var CHARACTER: CharacterBody3D = $".."
@export var SENSITIVITY: float = 0.003
@export var TILT_LOWER_LIMIT = deg_to_rad(-90)
@export var TILT_UPPER_LIMIT = deg_to_rad(90)


func _ready():
	# We change the mouse mode to capture inputs
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# Apparently similar to _input() but gets called later?
func _input(event):
	# I the mouse is moved, we rotate do 2 things
	if event is InputEventMouseMotion:
		# 1) We rotate the character's body and camera controller
		CHARACTER.transform.basis = CHARACTER.transform.basis.rotated(CHARACTER.transform.basis.y, -event.relative.x * SENSITIVITY)
		transform.basis = transform.basis.rotated(transform.basis.x, -event.relative.y * SENSITIVITY)
		# 2) We tilt the camera controller in between constant limits
		rotation.x = clamp(rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
