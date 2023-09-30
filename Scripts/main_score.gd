extends Node2D

var score: int = 0
var level: int = 1
var highscore
var motivationalWords = ["Madonna", "Amazing", "Amoeba", "Unbeliveable", "So good!", "Chicken", "Aminoacid"]  
# Called when the node enters the scene tree for the first time.

func _ready():
	$GameOverScreen.visible = false
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		highscore = save_file.get_32()
	else:
		highscore = 0
		save_game()

func _on_plus_score_pressed():
	score += 100
	$ColorRect/MarginContainer/Fire/GPUParticles2D.process_material.initial_velocity_min += 10
	$ColorRect/MarginContainer/HBoxContainer/Score_Value.text = str(score)
		
	if score % 500 == 0:  
		var randomIndex = randi() % motivationalWords.size()  
		var randomMotivationalWord = motivationalWords[randomIndex]  
		$ColorRect/TempMessage.text = randomMotivationalWord  # Show the score text  
		$ColorRect/TempMessage.visible = true  # Show the score text  
		$scoreTextTimer.start()  # Start the timer
		print ("timer started")

func _on_score_text_timer_timeout():
	print ("timer ended")
	$ColorRect/TempMessage.visible = false



func _on_minus_score_pressed():
	score -= 1000
	$ColorRect/MarginContainer/Fire/GPUParticles2D.process_material.initial_velocity_min -= 50
	$ColorRect/MarginContainer/HBoxContainer/Score_Value.text = str(score)


func _on_plus_level_pressed():
	level += 1
	$MarginContainer/HBoxContainer/Level_Value.text = str(level)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(highscore)

func _on_minus_level_pressed():
	level -= 1
	$MarginContainer/HBoxContainer/Level_Value.text = str(level)

func _on_game_over_pressed():
	if score > highscore:
		highscore = score
	$GameOverScreen.display_scores(score, highscore)
	
	save_game()
	$GameOverScreen.visible = true

