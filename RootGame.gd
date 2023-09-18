extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		to_character_select()

func to_character_select():
	var characterSelect = ResourceLoader.load("res://caracter_select.tscn")
	var characterSelectInst = characterSelect.instantiate()
	
	remove_child(get_node("Game"))
	add_child(characterSelectInst)


func _on_caracter_select_character_selected(character):
	
	GlobalSingleton.set_current_character(character)
	
	var game = ResourceLoader.load("res://game.tscn")
	var gameInst = game.instantiate()
	remove_child(get_node("CaracterSelect"))
	add_child(gameInst)

	
