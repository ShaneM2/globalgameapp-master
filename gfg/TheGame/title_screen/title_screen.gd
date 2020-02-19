extends Node

var scene_path_to_load

func _ready():
	print("Hello from Main")
	#for button in $Menu/CenterRow/Buttons.get_children():
	#	button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])


func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_PlayButton_pressed():
	get_tree().change_scene('res://play/map.tscn')

func _on_FadeIn_fadeFinished():
	get_tree().change_scene('res://play/map.tscn')