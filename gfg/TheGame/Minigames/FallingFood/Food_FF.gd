# Food_FF - a RigidBody2D that adds a single food object to a group of foods 
# (code by Nick Bonovia and Brooke Smith)
extends RigidBody2D

export(String) var food_type

func _ready():
	add_to_group("foods")