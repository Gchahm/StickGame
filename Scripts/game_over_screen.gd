extends Control

var _current_score

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
	
	$ColorRect/Panel/SaveContainer.visible = false
	$ColorRect/Panel/MotivationalMessage.text = randomMessage

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scene/main_score.tscn")

func _on_quit_pressed():
	get_tree().quit()
	
func display_scores(score):
	_current_score = score
	
	if _current_score > Saver.get_high_score():
		$ColorRect/Panel/SaveContainer.visible = true
	
	$"ColorRect/Panel/VBox/High-Score".text = "Hi-Score: " + str(Saver.get_high_score())
	$ColorRect/Panel/VBox/Score.text = "Score: " + str(score)

func _on_save_score(): 
	var player_name = $ColorRect/Panel/SaveContainer/LineEdit.get_text()
	if len(player_name) != 0:
		Saver.save_score(player_name, _current_score)
	_on_retry_pressed()
	
	
