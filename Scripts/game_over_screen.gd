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

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scene/main_score.tscn")

func _on_quit_pressed():
	get_tree().quit()
	
func display_scores (score, highscore):
	$"ColorRect/Panel/VBox/High-Score".text = "Hi-Score: " + str(highscore)
	$ColorRect/Panel/VBox/Score.text = "Score: " + str(score)
