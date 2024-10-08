extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 4.5
@onready var tool : Node3D = $CameraController/CharacterCamera/ToolController
@onready var camera : Camera3D = $CameraController/CharacterCamera
@onready var camera_controller : Node3D = $CameraController


var t_bob = 0
const HEADBOB_FREQ = 11
const HEADBOB_AMP = 0.01

func _ready() -> void:
	if camera.get_node_or_null("ToolController"):
		camera.remove_child(tool)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

# Headbob handling
	if velocity.length() != 0 and is_on_floor():
		t_bob += delta * HEADBOB_FREQ * float(is_on_floor())
		_headbob(t_bob)
	
	move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	# Tool toggling
	if Input.is_action_just_pressed("secondary_action"):
		# If tool active, remove it
		if camera.get_node_or_null("ToolController"):
			camera.remove_child(tool)
		# If tool not active, add it
		else:
			camera.add_child(tool)

# Generates headbob
func _headbob(time):
	camera_controller.transform.origin.y += sin(time) * HEADBOB_AMP
	camera_controller.transform.origin.x += cos(time / 2) * HEADBOB_AMP / 2
