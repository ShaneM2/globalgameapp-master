extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func json_to_dict(file_path) -> Dictionary:
	"""
	Parses a JSON file and returns it as a dictionary
	"""
	var file = File.new()
	assert file.file_exists(file_path)

	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert dialogue.size() > 0
	return dialogue


## Returns a random dictionary value
## if dictionary is empty, return null
##
func rand_dict_val(dict : Dictionary):
	var keys = dict.keys()
	var numKeys = keys.size()
	if numKeys > 0:
		return dict[keys[randi() % numKeys]]
	else:
		return null