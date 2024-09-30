extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Aiming at labeled objects
# Only labeled objects are checked, as they have their own collison layer
func _on_aiming_area_body_entered(body: Node3D) -> void:
	if body.get_node("LabelProperty"):
		var label = body.get_node("LabelProperty")
		print(label.label_name)
