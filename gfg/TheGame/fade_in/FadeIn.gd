extends ColorRect

signal fadeFinished
signal gameFadeFinished

func fade_in():
	$AnimationPlayer.play("fade_in")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fadeFinished")