extends Node3D

@onready var levels = [
	preload("res://Scenes/Level Prototypes and Whiteboxing/waiting_room.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for p_level in levels:
		var level = p_level.instantiate()
		add_child(level)
