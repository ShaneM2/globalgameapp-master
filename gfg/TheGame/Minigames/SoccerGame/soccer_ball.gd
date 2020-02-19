extends RigidBody2D

export (NodePath) var score_screen_node_path

onready var score_screen = get_node(score_screen_node_path)

var fired = 0
export var speed = 1000.0
var pos
var reset_state = false
var score = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = self.global_position
	set_bounce(.8)

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		shoot_at_mouse(self.global_position)
		fired = 1

func shoot_at_mouse(start_pos):
	if(fired != 1):
		self.global_position = start_pos
		var direction = (get_global_mouse_position() - start_pos).normalized()
		self.linear_velocity = direction * speed
		self.set_angular_velocity(10.0)
		get_node("soccer_kick").play(0.0)

func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, pos)
		state.linear_velocity = Vector2()
		state.set_angular_velocity(0.0)
		fired = 0
		reset_state = false

func _on_goal_net_body_entered(body):
	yield(get_tree().create_timer(.3), "timeout")
	reset_state = true


func _on_Area2D_body_entered(body):
	reset_state = true

func _on_Timer_timeout():
	get_tree().paused = true


func _on_pause_button_pressed():
	reset_state = true


func _on_goal_line_body_entered(body):
	#if body.get_name() == "goal_line":
		score = score + 1
		get_node("../../UI_GS/Label").set_text("Score: " + str(score))
		reset_state = true


func _on_timer_label_timeout():
	get_node("../../UI_GS/Label").hide()
	get_node("../soccer_ball").hide()
	get_node("../goal_net").hide()
	get_node("../Path2D").hide()
	get_node("../../UI_GS/timer_label").hide()
	get_node("../half_field").hide()
	get_node("../../UI_GS/pause_button").hide()
	score_screen.displayScore(score)