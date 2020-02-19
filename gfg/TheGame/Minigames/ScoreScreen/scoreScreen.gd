extends Panel

export (String) var gameName

func displayFoodScore(var score, var fruits, var veggies):
	get_tree().paused = true
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	self.show()
	$VBoxContainer.get_child(0).text = gameName
	$VBoxContainer.get_child(2).text = "Score: " + str(score) + "\nFruits: " + str(fruits) + "\nVegetables: " + str(veggies)

func displayScore(var score):
	get_tree().paused = true
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	self.show()
	$VBoxContainer.get_child(0).text = gameName
	$VBoxContainer.get_child(2).text = "Score: " + str(score)

func _on_backToMapBtn_pressed():
	get_tree().change_scene("res://play/map.tscn")
	get_tree().paused = false
