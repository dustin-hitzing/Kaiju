extends Node
class_name  Global_Singleton


var characterResPrefix = "res://monsters/"
var chacterSuffix = ".gltf"

var characterResString = null

func set_current_character(character):
	characterResString =  characterResPrefix + character + chacterSuffix

func build_character():
	return ResourceLoader.load(characterResString)
