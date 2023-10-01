extends Node

var score: int = 0
var level: int = 1
var highscore
var targetScore: int = 0
var motivationalWords = ["Madonna!", "Superb!", "Flibbergabber!", "Unbeliveable!", "So good!", "Chicken!", "Professional!"]  
var incrementAmount: int = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	$GameOverScreen.visible = false
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		highscore = save_file.get_32()
	else:
		highscore = 0
		save_game()
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_min = 300
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_max = 300
	$ColorRect/Fireworks.visible = false

func update_score(value):
	targetScore += value
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_min += value
	$incrementScore.start()	
	if value > 0:
		_motivational_speech()
		
func _motivational_speech():
	if targetScore % 50 == 0:  
		var randomIndex = randi() % motivationalWords.size()  
		var randomMotivationalWord = motivationalWords[randomIndex]  
		$ColorRect/TempMessage.text = randomMotivationalWord  # Show the score text  
		$ColorRect/TempMessage.visible = true  # Show the score text  
		$ColorRect/Fireworks.visible = true
		$scoreTextTimer.start()  # Start the timer
		
func _on_plus_score_pressed():
	update_score(10)

func _on_minus_score_pressed():
	update_score(-1000)

func _on_increment_score_timeout():
	score += incrementAmount
	$ColorRect/MarginContainer/HBoxContainer/Score_Value.text = str(score)
	if score < targetScore:  
		$incrementScore.start()  
	else:  
		$incrementScore.stop()  

func _on_score_text_timer_timeout():
	$ColorRect/TempMessage.visible = false
	$ColorRect/Fireworks.visible = false




func _on_plus_level_pressed():
	level += 1
	$ColorRect/MarginContainer2/HBoxContainer/Level_Value.text = str(level)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(highscore)

func _on_minus_level_pressed():
	level -= 1
	$ColorRect/MarginContainer2/HBoxContainer/Level_Value.text = str(level)

func _on_game_over_pressed():
	if score > highscore:
		highscore = score
	$GameOverScreen.display_scores(score, highscore)
	save_game()
	$GameOverScreen.visible = true




