# SOURCE: https://www.youtube.com/watch?v=A3HLeyaBCq4&list=PLQZiuyZoMHcgqP-ERsVE4x4JSFojLdcBZ

extends CharacterBody3D

@export var SPEED = 5.0
@export var SENSITIVITY = 0.003
# Scenes
@onready var CHARACTER = $"."
@onready var CAMERA_CONTROLLER = $PlayerCameraController
# Camera properties
@export var TILT_LOWER_LIMIT = deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT = deg_to_rad(90.0)
# Headbob properties
var t_bob = 0
const HEADBOB_FREQ = 11
const HEADBOB_AMP = 0.01

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	# We change the mouse mode to capture inputs
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Handling our custom inputs (I think that's the was to do it?)
func _input(event):
	# Right now escape quits.
	# Ultimately it should open the pause menu.
	if event.is_action_pressed("escape"):
		get_tree().quit()

# Apparently similar to _input() but gets called later?
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		CHARACTER.transform.basis = CHARACTER.transform.basis.rotated(CHARACTER.transform.basis.y, -event.relative.x * SENSITIVITY)
		CAMERA_CONTROLLER.transform.basis = CAMERA_CONTROLLER.transform.basis.rotated(CAMERA_CONTROLLER.transform.basis.x, -event.relative.y * SENSITIVITY)
		CAMERA_CONTROLLER.rotation.x = clamp(CAMERA_CONTROLLER.rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)


var test = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if velocity.length() != 0 and is_on_floor():
		t_bob += delta * HEADBOB_FREQ * float(is_on_floor())
		_headbob(t_bob)
	
	move_and_slide()

# Generates headbob
func _headbob(time):
	CAMERA_CONTROLLER.transform.origin.y += sin(time) * HEADBOB_AMP
	CAMERA_CONTROLLER.transform.origin.x += cos(time / 2) * HEADBOB_AMP / 2
