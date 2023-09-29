extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$flyman.miss.connect(_miss)
	$Controls.box_pressed.connect(_box_pressed)
	
	for i in range(1, 5):
		$Controls.update_box(i-1, str(i))

func randomLetterOrNumber():
	var characters = "1234"
	var random_index = randi() % characters.length()
	var random_char = characters[random_index]
	return random_char

func _miss(fly_index):
	pass#$Controls.update_box(fly_index, randomLetterOrNumber())

func _box_pressed(box_index):
	$flyman.try_catch(box_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
