extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var scores = load_scores("user://scores.data")
	
	for p in scores:
		$Container/Table/FirstColumn/Names.text += "\n" + p[0] 
		$Container/Table/SecondColumn/Scores.text += "\n" + str(p[1]) 


# Called every frame. 'delta' is the elapsed time since  the previous frame.
func _process(delta):
	pass
	
	
func _on_back():
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")


func load_scores(file_name: String): 
	var scores = []
	var file = FileAccess.open(file_name, FileAccess.READ)
	
	if file:
		while !file.eof_reached():
			var pair = file.get_csv_line()
			if len(pair) == 2:
				scores.append(pair)
	else:
		file = FileAccess.open(file_name, FileAccess.WRITE)
		file.store_csv_line(PackedStringArray(["Denys", "1"]))
	
	file.close()
	scores.sort_custom(sort_scores)
	return scores

func sort_scores(a, b) -> bool:
	return int(a[1]) > int(b[1])

	


