extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5

@onready var anim_tree := $AnimationTree
#@onready var character := $CharacterArmature
var character = null
var is_attacking = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	var characterResource = GlobalSingleton.build_character()
	var characterInst = characterResource.instantiate()
	add_child(characterInst)
	
	character = characterInst.get_node("CharacterArmature")
	var character_anim_player = characterInst.get_node("AnimationPlayer")
	
	anim_tree.set_animation_player(character_anim_player.get_path())
	anim_tree.active = true
	
	

func _physics_process(delta: float) -> void:
	handle_movement(delta)

	
	
func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if(Input.is_action_just_pressed("punch")):
		anim_tree["parameters/conditions/punch"] = true
		is_attacking=true
	else:
		anim_tree["parameters/conditions/punch"] = false
		is_attacking = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()



	#creates a new basis matrix for the character
	if input_dir != Vector2.ZERO:
		#gets the arctangent of the vector; which is the angle in radians
		var angle := atan2(direction.x, direction.z)
		character.transform.basis = Basis(Vector3.UP, angle)
		anim_tree["parameters/conditions/is_moving"] = true
		anim_tree["parameters/conditions/is_idle"] = false
	else:
		anim_tree["parameters/conditions/is_idle"] = true
		anim_tree["parameters/conditions/is_moving"] = false

	#set the velocity needed for the move_and_slide func to work
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



