extends Label

signal timeout

export (int) var seconds

onready var s = seconds

var ms = 0
var stop = 0
var paused = false

func start_timer():
	paused = false
	$countdown.set_paused(false)

func pause_timer():
	paused = true
	$countdown.set_paused(true)

func reset_timer():
	s = seconds
	ms = 0
	stop = 0
	set_text(str(s)+":"+str(ms))
	$countdown.start(float(seconds))

func _process(delta):
	if !paused:
		if ms < 0:
			s = s - 1
			ms = 9
	
		if(ms == 0 && s == 0):
			stop = 1
	
		if stop != 1:
			set_text(str(s)+":"+str(ms))
		else:
			set_text("0:0")

func _on_ticker_timeout():
	if !paused:
		ms = ms - 1

func _on_countdown_timeout():
	pause_timer()
	set_text("0.0")
	emit_signal("timeout")