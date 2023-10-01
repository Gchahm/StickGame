extends Control

var _current_score
var _scores

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
	
func set_scores(scores):
	_scores = scores
	
func display_scores(score, highscore):
	_current_score = score
	
	if score > highscore:
		$ColorRect/Panel/SaveContainer.visible = true
	
	$"ColorRect/Panel/VBox/High-Score".text = "Hi-Score: " + str(highscore)
	$ColorRect/Panel/VBox/Score.text = "Score: " + str(score)

func _on_save_score(): 
	var file = FileAccess.open("user://scores.data", FileAccess.WRITE)
	_scores.append(PackedStringArray(["Test" + str(_current_score), str(_current_score)]))
	for s in _scores:
		file.store_csv_line(s)
	file.close()
