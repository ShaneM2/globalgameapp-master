## Player - KinematicBody2D that represents the basket
## (code by Nick Bonovia and Brooke Smith)
extends KinematicBody2D

export (NodePath) var score_screen_node_path

onready var scoreScreen = get_node(score_screen_node_path)

# Speed of the basket
export (int) var speed = 400 # Speed of the basket
var target = Vector2()       # Target location (where the player wants the basket to move)
var direction = 0.0          # Direction the player is moving
var score = 0                # Current score
var num_veg = 0              # Current number of vegetables caught
var num_fruit = 0            # Current number of fruits caught
var num_carb = 0             # Current number of carbs caught
var num_protein = 0          # Current number of proteins caught

## When the scene enters the scene tree:
## The basket starts in the middle of the screen (at the bottom)
## The target location is set to the start location
func _ready():
	target = self.position


## This function is called on an event
## If the event is a "ScreenTouch" (a tap) or a mouse press:
## The target is set to the position of that tap/press
func _unhandled_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		target = event.get_position()



#func _physics_process(delta):
#	pass


## _process is called once per frame
## This function will find the distance between the target and current position
## Then sets the direction to 1 or -1 depending on if the player tapped to the left or right of the basket
## Finally it checks d > r*t, if true, the current position must be adjusted
func _process(delta):
	var distance = target.x - self.position.x
	var direction = 1 if target.x > self.position.x else -1

	if distance * direction > speed * delta:
		self.position.x += direction * speed * delta

## This function is called when an object enters the player's Area2D
## If the object that entered the player's Area2D is a member of the "foods" group:
## the food is removed.
func _on_Area2D_body_entered(body):
	if (body.is_in_group("foods")):
		# Display Total Score
		score = score + 1
		get_node("../ScoresUI_FF/Score_FF").set_text("Total Score: " + str(score))

		# Display amount of each food caught
		if (body.food_type == "Vegetable"):
			num_veg += 1
			get_node("../ScoresUI_FF/Vegetable_Score_FF").set_text("Vegetables: " + str(num_veg))
		elif (body.food_type == "Fruit"):
			num_fruit += 1
			get_node("../ScoresUI_FF/Fruit_Score_FF").set_text("Fruits: " + str(num_fruit))
		elif (body.food_type == "Carb"):
			num_carb += 1
			get_node("../ScoresUI_FF/CarbScore_FF").set_text("Carbs: " + str(num_carb))
		elif (body.food_type == "Protein"):
			num_protein += 1
			get_node("../ScoresUI_FF/ProteinScore_FF").set_text("Proteins: " + str(num_protein))

		body.queue_free()


func _on_timer_label_timeout():
	var fruitCarbsScr = str(num_fruit) + "            Carbs: " + str(num_carb)
	var vegProtScore = str(num_veg) + "        Proteins: " + str(num_protein)
	scoreScreen.displayFoodScore(score, fruitCarbsScr, vegProtScore)
