extends Node2D

var score := 0
@onready var score_scene = $Main_Score

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
	score_scene.update_score(-5)

func _catch(fly_index):
	score_scene.update_score(10)
	AudioScene.PlaySound(AudioScene.SoundType.Snack, null)
	print("Catch: " + str(fly_index))

func _sting(fly_index):
	score_scene.update_score(-20)
	# If my code is right, the second param will be the "fly" object for the relevant key
	AudioScene.PlaySound(AudioScene.SoundType.Sting, $flyman.get_children()[fly_index].get_child(0))
	print("Sting: " + str(fly_index))

func _box_pressed(box_index):
	$flyman.try_catch(box_index)
	var newChamFrame = 0
	
	if (box_index < 2):
		newChamFrame = 1
	elif (box_index == 2):
		newChamFrame = 2
	
	$Cham.frame = newChamFrame	
	$Cham/shadow.frame = newChamFrame
	
	print("Score: " + str(score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
