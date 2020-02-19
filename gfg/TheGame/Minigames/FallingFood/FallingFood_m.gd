extends Node2D

export (PackedScene) var Food_FF
var score

func _ready():
	randomize()
	print("Starting minigame")
	new_game()

#func _on_Player_FF_body_entered(body):
#	if (body.is_in_group("Foods_FF")):
#		body.queue_free()    # Removes the food when it hits the basket
#		emit_signal("hit")
#		print("dropped inside")

func _on_Food_Timer_FF_timeout():
	# Choose random location on Path2d
	$Food_Path_FF / Food_Path_Spawn_FF.set_offset(randi())
	# Create a Food Instance
	var food = Food_FF.instance()
	add_child(food)
	# Set the food's position to a random location
	food.position = $Food_Path_FF/Food_Path_Spawn_FF.position


func _on_Game_Timer_FF_timeout():
	$Food_Timer_FF.start()


func new_game():
	score = 0
	$Game_Timer_FF.start()

func _on_Player_FF_catch():
	score += 1
	print_debug(score)