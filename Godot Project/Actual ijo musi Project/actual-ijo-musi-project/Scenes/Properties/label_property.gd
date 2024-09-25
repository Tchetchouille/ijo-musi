extends Node

# Variables used to store the parent and label file names
@onready var parent = get_parent()
@onready var label_name = parent.name.to_snake_case()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Completing label name
	label_name += "_label.tres"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
