extends TextureRect

var rng = RandomNumberGenerator.new()
var is_visible : bool = false
var is_active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rng.randf() <= 0.00002:
		var tween = get_tree().create_tween()
		tween.tween_property($Curtain, "color", Color(0, 0, 0, 0), 3.0)
		is_active = true
		await tween.finished
		$Timer.start()


func _on_mouse_entered() -> void:
	if not is_visible and not is_active:
		var tween = get_tree().create_tween()
		tween.tween_property($Curtain, "color", Color(0, 0, 0, 0), 0.05)
		is_visible = true

func _on_mouse_exited() -> void:
	if is_visible and not is_active:
		var tween = get_tree().create_tween()
		tween.tween_property($Curtain, "color", Color(0, 0, 0, 1), 0.2)
		await tween.finished
		is_visible = false

func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Curtain, "color", Color(0, 0, 0, 1), 1.0)
	await tween.finished
	is_active = false
