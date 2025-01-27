extends CharacterBody3D

@onready var root: Node3D = $".."

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var menu_open: bool

func _ready() -> void:
	root.menu_state_changed.connect(_on_menu_state_changed)


# Movement & Gravity
func _physics_process(delta: float) -> void:
	#region: Input
	var input_jump: bool
	var input_dir: Vector2
	
	# Get input if the menu is not open.
	if menu_open == false:
		input_jump = Input.is_action_just_pressed("ui_accept")
		input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#endregion
	
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if input_jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle movement/deceleration.
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()


func _on_menu_state_changed(signal_menu_open: bool) -> void:
	menu_open = signal_menu_open
