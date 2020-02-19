extends Node2D

onready var pausemenu = get_node("/root/pauseScreen")

func _ready():
	$UI_GS/timer_label.reset_timer()


func _on_pause_button_pressed():
	pausemenu.pause_screen()