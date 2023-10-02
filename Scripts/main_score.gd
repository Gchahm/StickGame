extends Node

var score: int = 0
var life: int = 5
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

func receive_life_damage():
	life -= 1
	if life <= 0:
		$ColorRect/LivesUI/HBoxContainer/Life.text = "x0"
		GlobalStats.currentScore = score
		var scene = load("res://Scene/game_over_screen.tscn")
		get_tree().change_scene_to_packed(scene)
		
	else:
		$ColorRect/LivesUI/HBoxContainer/Life.text = "x" + str(life)

func update_score(value) -> bool:
	targetScore += value
	var originalLevel = level
	
	if targetScore > 50:
		level = 2
	if targetScore > 100:
		level = 3
	if targetScore > 200:
		level = 4
	if targetScore > 400:
		level = 5
	if targetScore > 600:
		level = 6
	if targetScore > 1000:
		level = 7
	if targetScore > 1500:
		level = 8
	
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_min += value
	if (targetScore > score):
		incrementAmount = abs(incrementAmount)
	else:
		incrementAmount = -abs(incrementAmount)
		
	$incrementScore.start()	
	if value > 0:
		_motivational_speech()
		
	$ColorRect/MarginContainer2/HBoxContainer/Level_Value.text = str(level)
	return level != originalLevel
		
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
	if (incrementAmount > 0 && score >= targetScore) || (incrementAmount < 0  && score <= targetScore):
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




