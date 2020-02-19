## Ground_FF - An Area2D that represents the ground
## (code by Nick Bonovia and Brooke Smith)
extends Area2D

func _ready():
	pass


## When an object enters the Ground Area2D: 
## this function first checks if it is a food object 
## If it is a food object, the food is removed.
func _on_Ground_FF_body_entered(body):
	print(body.get_name())
	if (body.get_name() == "Food_FF"):
		body.queue_free()