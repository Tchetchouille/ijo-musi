extends OmniLight3D

var rng = RandomNumberGenerator.new()
var fluct = 0

# Currently set tovar for editor accessibility.
# This is bad practice. Should be changed for end product
@export var base_intensity : float = 1
@export var flicker_intensity : float = 0.2

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fluct += rng.randf_range(-0.1, 0.1)
	light_energy = base_intensity + flicker_intensity * cos(fluct)
	print(get_instance_id())
	print(fluct)
