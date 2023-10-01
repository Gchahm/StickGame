extends Node

var score: int = 0
var level: int = 1
var scores
var targetScore: int = 0
var motivationalWords = ["Madonna!", "Superb!", "Flibbergabber!", "Unbeliveable!", "So good!", "Chicken!", "Professional!"]  
var incrementAmount: int = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	scores = load_scores()
	
	$GameOverScreen.visible = false
	$GameOverScreen.set_scores(scores)
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_min = 300
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_max = 300
	$ColorRect/Fireworks.visible = false

func _on_plus_score_pressed():
	targetScore += 10
	$ColorRect/MarginContainer/Fire/Fire.process_material.initial_velocity_min += 10
	$incrementScore.start()	
	if targetScore % 50 == 0:  
		var randomIndex = randi() % motivationalWords.size()  
		var randomMotivationalWord = motivationalWords[randomIndex]  
		$ColorRect/TempMessage.text = randomMotivationalWord  # Show the score text  
		$ColorRect/TempMessage.visible = true  # Show the score text  
		$ColorRect/Fireworks.visible = true
		$scoreTextTimer.start()  # Start the timer

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


func _on_minus_score_pressed():
	score -= 1000
	$ColorRect/MarginContainer/Fire/GPUParticles2D.process_material.initial_velocity_min -= 100
	$ColorRect/MarginContainer/HBoxContainer/Score_Value.text = str(score)

func _on_plus_level_pressed():
	level += 1
	$MarginContainer/HBoxContainer/Level_Value.text = str(level)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(highscore)

func _on_minus_level_pressed():
	level -= 1
	$ColorRect/MarginContainer2/HBoxContainer/Level_Value.text = str(level)

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



