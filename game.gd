extends Node2D

var score := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$flyman.miss.connect(_miss)
	$flyman.catch.connect(_catch)
	$flyman.sting.connect(_sting)
	$Controls.box_pressed.connect(_box_pressed)
	
	for i in range(1, 5):
		$Controls.update_box(i-1, str(i))

func randomLetterOrNumber():
	var characters = "1234"
	var random_index = randi() % characters.length()
	var random_char = characters[random_index]
	return random_char

func _miss(fly_index):
	score -= 5
	pass#$Controls.update_box(fly_index, randomLetterOrNumber())

func _catch(fly_index):
	score += 10
	print("Catch: " + str(fly_index))

func _sting(fly_index):
	score -= 20
	print("Sting: " + str(fly_index))

func _box_pressed(box_index):
	$flyman.try_catch(box_index)
	print("Score: " + str(score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
