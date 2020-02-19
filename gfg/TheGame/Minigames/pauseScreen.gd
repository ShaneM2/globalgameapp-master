## Script for pause menu
## Original pause menu by Sellars Levy
## Animations and making the pause menu global
## by Nick Bonavia

extends CanvasLayer

## color constant for clear background
const clearColor = Color(0, 0, 0, 0)

## Export the faded color for background
export (Color) var transparentBG = Color(1, 1, 1, 0.6)
export (Vector2) var size = Vector2(1024, 600)
## Get the dimensions of pause menu items 
onready var tween = get_node("Tween")
onready var panelRect = $Panel.get_rect().size
## calculate (x, y) for pause panel so it's in the center of the screen
onready var initPos = Vector2((size.x/2) - (panelRect.x/2), -size.y)
onready var finalPos = Vector2((size.x/2) - (panelRect.x/2), (size.y/2) - (panelRect.y/2))


## This function is called when a minigame needs to pause
func pause_screen():
	## Pause the game
	get_tree().paused = true
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	## make background visible
	$pauseBG.show()
	## setup animation properties for pause menu and background
	tween.interpolate_property($Panel, "rect_position", initPos, finalPos, 2.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.interpolate_property($pauseBG, "modulate", clearColor, transparentBG, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	## wait till all tween animations are complete
	yield(tween, "tween_all_completed")
	## Enable pause menu buttons
	$Panel/HBoxContainer/VBoxContainer/resumeButton.disabled = false
	$Panel/HBoxContainer/VBoxContainer/backToMapBtn.disabled = false


## If the user resumes their game this function is called
func _on_resumeButton_pressed():
	## Disable pause menu buttons and animate menu off screen
	$Panel/HBoxContainer/VBoxContainer/resumeButton.disabled = true
	$Panel/HBoxContainer/VBoxContainer/backToMapBtn.disabled = true
	tween.interpolate_property($Panel, "rect_position", null, initPos, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property($pauseBG, "modulate", null, clearColor, 0.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	## Wait till animation is complete
	yield(tween, "tween_all_completed")
	## hide background and unpause game
	$pauseBG.hide()
	get_tree().paused = false

## If the user quits the game, this returns them to the
## map screen
func _on_backToMapBtn_pressed():
	## Disable pause menu buttons and setup animation properties for menu to leave
	## and transition to map screen
	$Panel/HBoxContainer/VBoxContainer/resumeButton.disabled = true
	$Panel/HBoxContainer/VBoxContainer/backToMapBtn.disabled = true
	tween.interpolate_property($Panel, "rect_position", null, initPos, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property($pauseBG, "modulate", null, Color.black, 0.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	## wait for twen to complete
	yield(tween, "tween_all_completed")
	## hide this bg for next use
	$pauseBG.hide()
	$pauseBG.modulate = clearColor
	## Change to map screen
	get_tree().change_scene("res://play/map.tscn")
	get_tree().paused = false


## Standard ready function. Called once when the pause menu
## is created. Basically the constructor.
func _ready():
	## initialize pause menu to not be seen
	$Panel/HBoxContainer/VBoxContainer/resumeButton.disabled = true
	$Panel/HBoxContainer/VBoxContainer/backToMapBtn.disabled = true
	$pauseBG.modulate = clearColor
	$pauseBG.hide()