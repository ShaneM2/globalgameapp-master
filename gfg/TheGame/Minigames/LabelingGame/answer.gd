extends ColorRect

signal answerFinished

func correct():
	$AnimationPlayer.play("correct_answer")

func incorrect():
	$AnimationPlayer.play("incorrect_answer")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("answerFinished")
