extends Node3D

@onready var levels = [
	preload("res://Scenes/Level Prototypes and Whiteboxing/waiting_room.tscn"),
	preload("res://Scenes/Level Prototypes and Whiteboxing/pond.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(0)

func load_level(index):
	var level = levels[index].instantiate()
	add_child(level)
	
func load_all_levels():
	for p_level in levels:
		var level = p_level.instantiate()
		add_child(level)
