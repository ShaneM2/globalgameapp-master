extends Node2D

export (NodePath) var map_path
export (String, FILE, "*.json") var dialogue_file_path : String
export (String) var game_to_load
export (bool) var unlocked
export (bool) var playTutorial

export (Texture) var unlocked_button
export (Texture) var locked_button

onready var map : Map = get_node(map_path)
onready var button = $TextureButton
onready var stars = [$Star1, $Star2, $Star3]

func _ready():
	setup()

func setup():
	if unlocked:
		button.texture_normal = unlocked_button
	else:
		button.texture_normal = locked_button

func _on_LevelButton_pressed():
	#var dialogue : Dictionary =  load_dialogue(dialogue_file_path)
	print("Map button pressed")
	
	if (playTutorial):
		map.play_dialogue(dialogue_file_path)
		yield(map, "dialogue_ended")
	#emit_signal("finished")
	get_tree().change_scene(game_to_load)
