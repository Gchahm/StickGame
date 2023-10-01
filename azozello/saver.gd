extends Node

var text = "hello"

var _file_name = "user://scores.data"
var _scores = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_scores = _load_scores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _clear_scores():
	var file = FileAccess.open(_file_name, FileAccess.WRITE)
	file.store_csv_line(PackedStringArray(["Noob", "0"]))
	file.close()
	
func _load_scores():
	var scores = []
	var file = FileAccess.open(_file_name, FileAccess.READ)
	
	if file:
		while !file.eof_reached():
			var pair = file.get_csv_line()
			if len(pair) == 2:
				scores.append(pair)
	else:
		print("Create new file")
		file = FileAccess.open(_file_name, FileAccess.WRITE)
		scores.append(["Noob", "0"])
	
	file.close()
	scores.sort_custom(_sort_scores)
	return scores
	
func _sort_scores(a, b) -> bool:
	return int(a[1]) > int(b[1])
	
func get_scores():
	_scores.sort_custom(_sort_scores)
	return _scores
	
func get_high_score():
	return int(get_scores()[0][1])

func save_score(name: String, score: int):
	_scores.append(PackedStringArray([name, str(score)]))
	_scores.sort_custom(_sort_scores)
	
	var file = FileAccess.open(_file_name, FileAccess.WRITE)
	
	for s in _scores:
		file.store_csv_line(s)
	
	file.close()
