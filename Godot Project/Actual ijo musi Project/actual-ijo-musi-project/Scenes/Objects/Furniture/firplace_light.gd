extends OmniLight3D

var rng = RandomNumberGenerator.new()
var fluct = 0
var base_position : Vector3

# Currently set tovar for editor accessibility.
# This is bad practice. Should be changed for end product
@export var base_intensity : float = 1
@export var flicker_intensity : float = 0.2
@export var offset_intensity : float = 0.04
@export var flicker_speed : float = 0.2

func _ready():
	base_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Flickering.
	fluct += rng.randf_range(- flicker_speed, flicker_speed)
	light_energy = base_intensity + flicker_intensity * cos(fluct)
	position = base_position + Vector3(cos(fluct), 0, sin(fluct)) * offset_intensity
