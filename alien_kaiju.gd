extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5

@onready var anim_tree := $AnimationTree
@onready var character := $CharacterArmature

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	handle_movement(delta)



func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()



	#creates a new basis matrix for the character
	if input_dir != Vector2.ZERO:
		#gets the arctangent of the vector; which is the angle in radians
		var angle := atan2(direction.x, direction.z)
		character.transform.basis = Basis(Vector3.UP, angle)

	#set the velocity needed for the move_and_slide func to work
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	update_walk_cycle()
	move_and_slide()



func update_walk_cycle() -> void:
	anim_tree.set("parameters/Movement/blend_position", velocity.length())



