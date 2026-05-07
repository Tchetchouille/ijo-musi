extends TextureRect

var rng = RandomNumberGenerator.new()
var is_visible : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rng.randf() <= 0.00002 and not is_visible:
		toggle_visible(0, 1.0)
		is_visible = true
		$Timer.start()


func _on_mouse_entered() -> void:
	if not is_visible:
		toggle_visible(0, 0.05)
		is_visible = true

func _on_mouse_exited() -> void:
	if is_visible:
		toggle_visible(1, 0.5)
		is_visible = false

func _on_timer_timeout() -> void:
	print(is_visible)
	if is_visible:
		toggle_visible(1, 1.0)
		is_visible = false

func toggle_visible(v, t):
	var tween = get_tree().create_tween()
	tween.tween_property($Curtain, "color", Color(0, 0, 0, v), t)
