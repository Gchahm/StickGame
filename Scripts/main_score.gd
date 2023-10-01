extends Node2D

var score: int = 0
var level: int = 1
#var highscore
var scores
var motivationalWords = ["Madonna", "Amazing", "Amoeba", "Unbeliveable", "So good!", "Chicken", "Aminoacid"]  
# Called when the node enters the scene tree for the first time.

func _ready():
	scores = load_scores()
	
	$GameOverScreen.visible = false
	$GameOverScreen.set_scores(scores)

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

func _on_minus_level_pressed():
	level -= 1
	$MarginContainer/HBoxContainer/Level_Value.text = str(level)

func _on_game_over_pressed():
	var high_score = int(scores[0][1])
	
	$GameOverScreen.display_scores(score, high_score)
	$GameOverScreen.visible = true


func load_scores():
	var scores = []
	var file = FileAccess.open("user://scores.data", FileAccess.READ)
	
	if file:
		while !file.eof_reached():
			var pair = file.get_csv_line()
			if len(pair) == 2:
				scores.append(pair)
	else:
		print("Create new file")
		file = FileAccess.open("user://scores.data", FileAccess.WRITE)
		scores.append(["Noob", "0"])
	
	file.close()
	scores.sort_custom(sort_scores)
	return scores
	
func sort_scores(a, b) -> bool:
	return int(a[1]) > int(b[1])



