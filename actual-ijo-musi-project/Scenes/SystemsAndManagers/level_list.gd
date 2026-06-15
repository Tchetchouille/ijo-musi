extends Node3D

@onready var levels = [
	preload("res://Scenes/Levels/level_connect.tscn"),
	preload("res://Scenes/Levels/waiting_room.tscn"),
	preload("res://Scenes/Levels/pond.tscn"),
	preload("res://Scenes/Levels/Obsolete/proto_level.tscn")
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
