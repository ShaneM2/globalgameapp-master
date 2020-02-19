extends RichTextLabel

func _ready():
	self.visible = false



func _on_Timer_timeout():
	self.visible = true
	get_tree().paused = true
	yield(get_tree().create_timer(3.0), "timeout")
	get_tree().paused = false
	get_tree().change_scene("res://play/map.tscn")
