extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rage_quit_pressed():
	get_tree().quit()


func _on_retry_pressed():
	get_tree().reload_current_scene()
	
func set_score(value):
	$Panel/Score.text = "Score: " + str(value)
	
func set_highscore(value):
	$Panel/HighestScore.text = "Hi-Score: " +str(value)
