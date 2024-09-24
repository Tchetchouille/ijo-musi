extends Camera3D

@onready var tool : Node3D = $"../../ToolController"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Move and rotate the screen camera.
	if tool.is_inside_tree():
		position = tool.global_position
		rotation = tool.global_rotation
