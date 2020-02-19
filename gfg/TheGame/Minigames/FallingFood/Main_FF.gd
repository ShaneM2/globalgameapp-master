## The Main script for the Falling Food Minigame 
## (code by Nick Bonavia and Brooke Smith)
extends CanvasLayer

## (Nick) Added export vars. Foods now handles food types instead of
## Reading from a JSON file. Much cleaner now, so I removed the load
## food scene func.
export var SPAWN_TIME = 1
export (NodePath) var pauseScreen_node_path   ## Path to pause screen
export (NodePath) var pauseButton_node_path   ## Path to pause button
export (NodePath) var timerLabel_node_path    ## Path to timer label
export (Array, PackedScene) var Foods         ## Array of the food scenes

## Retieves the nodes in UI_FF when _ready is called
onready var pauseScreen = get_node("/root/pauseScreen")
onready var pauseButton = get_node(pauseButton_node_path)
onready var timerLabel = get_node(timerLabel_node_path)


## Called when the node enters the scene tree for the first time.
func _ready():
	$FoodSpawnTimer_FF.start(1)
	timerLabel.reset_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

## This function is called when the timer reaches a certain number indicating
## that a new food should be created
func _on_FoodSpawnTimer_FF_timeout():
	## Create a food instance and get it's spawn point
	var food = Foods[randi() % Foods.size()].instance()
	var spawnCount = $FoodSpawn_FF.get_curve().get_point_count()
	var spawnPoint = $FoodSpawn_FF.get_curve().get_point_position(randi() % spawnCount)
	
	## Set the foods spawn location and start timer
	food.position = spawnPoint
	add_child(food)
	$FoodSpawnTimer_FF.start(SPAWN_TIME)


func _on_pauseButton_pressed():
	pauseScreen.pause_screen()