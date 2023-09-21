extends Control

signal character_selected(character)
var starting_index = 9;

# Called when the node enters the scene tree for the first time.
func _ready():
	go_next_select()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("accept")):
		call_deferred("emit_signal","character_selected",get_selected_avatar())
	if(Input.is_action_just_pressed("left")):
		go_previous_select()
	if(Input.is_action_just_pressed("right")):
		go_next_select()


func get_selected_avatar() -> String:
	var nodes = get_tree().get_nodes_in_group("Avatar")
	for node in nodes:
		if(node.get_meta("selected")):
			var name  = node.get_meta("name")
			return name
	return ""

func go_next_select() -> void:
	starting_index += 1

	if(starting_index > 9):
		starting_index = 0

	var nodes = get_tree().get_nodes_in_group("Avatar")
	for node in nodes:
		if(node.get_meta("Index") == starting_index):
			node.set_meta("selected", true)
		else:
			node.set_meta("selected", false)

func go_previous_select() -> void:
	starting_index -= 1

	if(starting_index < 0):
		starting_index = 9

	var nodes = get_tree().get_nodes_in_group("Avatar")
	for node in nodes:
		if(node.get_meta("Index") == starting_index):
			node.set_meta("selected", true)
		else:
			node.set_meta("selected", false)




