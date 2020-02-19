extends Control

class_name Map

export (NodePath) var tutorial_panel_path
export (NodePath) var tutorial_bg_path
export (NodePath) var character_name_path
export (NodePath) var charater_image_path
export (NodePath) var dialogue_text_path
export (NodePath) var next_button_path
export (NodePath) var done_button_path

onready var tutorial_panel = get_node(tutorial_panel_path)
onready var tutorial_bg = get_node(tutorial_bg_path)
onready var character_name = get_node(character_name_path)
onready var charater_image = get_node(charater_image_path)
onready var dialogue_text = get_node(dialogue_text_path)
onready var next_button = get_node(next_button_path)
onready var done_button = get_node(done_button_path)

var dIndex = 0
var dSize = 0
var scene_to_load
var dialogue : Dictionary

signal dialogue_ended

func _on_BackButton_pressed():
	scene_to_load = "res://title_screen/TitleScreen.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fadeFinished():
	get_tree().change_scene(scene_to_load)

func play_dialogue(file_path):
	dialogue = load_dialogue(file_path)
	print(dialogue)
	dIndex = 0
	dSize = dialogue.size()
	tutorial_panel.show()
	tutorial_bg.show()
	charater_image.show()
	next_button.show()
	done_button.hide()
	tutorial_bg.texture = load(dialogue[str(dIndex)])
	update_dialogue()

func update_dialogue():
	dIndex += 1
	if (dIndex < dSize-1):
		character_name.text = dialogue[str(dIndex)]["name"]
		charater_image.texture = load(dialogue[str(dIndex)]["image"])
		dialogue_text.text = dialogue[str(dIndex)]["text"]
	else:
		character_name.text = dialogue[str(dIndex)]["name"]
		charater_image.texture = load(dialogue[str(dIndex)]["image"])
		dialogue_text.text = dialogue[str(dIndex)]["text"]
		next_button.hide()
		done_button.show()


func load_dialogue(file_path) -> Dictionary:
	"""
	Parses a JSON file and returns it as a dictionary
	"""
	var file = File.new()
	assert file.file_exists(file_path)

	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert dialogue.size() > 0
	return dialogue

func _on_NextBtn_pressed():
	update_dialogue()


func _on_DoneBtn_pressed():
	tutorial_panel.hide()
	tutorial_bg.hide()
	charater_image.hide()
	emit_signal("dialogue_ended")
