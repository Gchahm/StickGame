extends Control

var motivationalMessages = [  
	"You are worse than Igor at this!", 
	"Is you name Sam? So bad...",
	"You are worse than Guilherme at this!",
	"So bad.....omg!",
	"Why are you even trying?"  
]  
func _ready():
	var randomIndex = randi() % motivationalMessages.size()  
	var randomMessage = motivationalMessages[randomIndex] 
	$ColorRect/Panel/MotivationalMessage.text = randomMessage
	if (GlobalStats.currentScore > GlobalStats.highScore):
		GlobalStats.highScore = GlobalStats.currentScore
	
	display_scores (GlobalStats.currentScore, GlobalStats.highScore)

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_pressed():
	get_tree().quit()
	
func display_scores (score, highscore):
	$"ColorRect/Panel/VBox/High-Score".text = "Hi-Score: " + str(highscore)
	$ColorRect/Panel/VBox/Score.text = "Score: " + str(score)
