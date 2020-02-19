extends Path2D

onready var follower = get_node("PathFollow2D")

func _ready():
	set_process(true)

func _process(delta):
	follower.set_offset(follower.get_offset() + 500 * delta)