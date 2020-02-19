extends Control

export (NodePath) var image_name_node_path
export (NodePath) var image_node_path
export (NodePath) var button_one_node_path
export (NodePath) var button_two_node_path
export (NodePath) var question_node_path
#export (NodePath) var score_screen_node_path
export (NodePath) var current_score_node_path
export (NodePath) var button_one_label_node_path
export (NodePath) var button_two_label_node_path
export (NodePath) var pause_screen_node_path
export (NodePath) var timer_label_node_path

onready var imageName = get_node(image_name_node_path)
onready var image = get_node(image_node_path)
onready var btn1 = get_node(button_one_node_path)
onready var btn2 = get_node(button_two_node_path)
onready var questionHolder = get_node(question_node_path)
#onready var scoreScreen = get_node(score_screen_node_path)
onready var currentScore = get_node(current_score_node_path)
onready var btn1Label = get_node(button_one_label_node_path)
onready var btn2Label = get_node(button_two_label_node_path)
#onready var pauseScreen = get_node(pause_screen_node_path)
onready var pauseScreen = get_node("/root/pauseScreen")
onready var timerLabel = get_node(timer_label_node_path)

var done = false
var numQuestions = 12
var score = 0
var index = 0
var correctAnswer = null
var order = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

func _ready():
	#$scoreScreen.hide()
	randomize()
	order.shuffle()
	set_question()
	currentScore.text = "Score: " + str(score)
	timerLabel.start_timer()

func set_question():
	var question
	var qImage
	
	timerLabel.pause_timer()
	timerLabel.reset_timer()
	
	if (index < numQuestions):
		question = questionHolder.get_child(order[index])
		index += 1
		qImage = load(question.image_path)
		
		imageName.text = question.image_name
		image.texture = qImage
		correctAnswer = question.answer
		btn1Label.text = question.btn1Text
		btn2Label.text = question.btn2Text
	else:
		print("Your Score is: " + str(score))
		$scoreScreen.displayScore(score)

func _on_Button1_pressed():
	$answer.show()
	if (correctAnswer):
		print("Correct")
		$answer.correct()
		score += 1
		currentScore.text = "Score: " + str(score)
	else:
		print("Incorrect")
		$answer.incorrect()
	set_question()


func _on_Button2_pressed():
	$answer.show()
	if (!correctAnswer):
		print("Correct")
		$answer.correct()
		score += 1
		currentScore.text = "Score: " + str(score)
	else:
		print("Incorrect")
		$answer.incorrect()
	set_question()


func _on_answer_answerFinished():
	$answer.hide()
	timerLabel.start_timer()


func _on_timer_label_timeout():
	$answer.show()
	$answer.incorrect()
	set_question()


func _on_pauseButton_pressed():
	pauseScreen.pause_screen()
