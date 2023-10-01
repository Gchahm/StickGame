extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var scores = Saver.get_scores()
	
	for p in scores:
		$Container/Table/FirstColumn/Names.text += "\n" + p[0] 
		$Container/Table/SecondColumn/Scores.text += "\n" + str(p[1]) 


# Called every frame. 'delta' is the elapsed time since  the previous frame.
func _process(delta):
	pass
	
	
func _on_back():
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")
