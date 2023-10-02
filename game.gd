extends Node2D

class_name game

var score := 0
signal level_increased

	
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
	score_scene.receive_life_damage()
	score_scene.update_score(-5)
	pass#$Controls.update_box(fly_index, randomLetterOrNumber())

func _catch(fly_index):
	var fly_position = $flyman.get_fly_position(fly_index)
	PointPopin.popin(self, fly_position, "NOM")

	if score_scene.update_score(10) == true:
		level_increased.emit()
	print("Catch: " + str(fly_index))

func _sting(fly_index):
	score_scene.update_score(-20)
	# If my code is right, the second param will be the "fly" object for the relevant key
	#AudioScene.PlaySound(AudioScene.SoundType.Sting, $flyman.get_children()[fly_index].get_child(0))
	print("Sting: " + str(fly_index))

func _box_pressed(box_index):
	var soundObject = AudioScene.PlaySound(AudioScene.SoundType.Slurp, null)
	# newAudioStreamPlayer.finished.connect(queue_free.bind(newAudioStreamPlayer))
	var caught = $flyman.try_catch(box_index, soundObject)
	var newChamFrame = 0
	
	if (box_index < 2):
		newChamFrame = 1
	elif (box_index == 2):
		newChamFrame = 2
	
	$Cham.frame = newChamFrame	
	$Cham/shadow.frame = newChamFrame
	
	var fly_position = $flyman.get_fly_position(box_index)


	var tween = $Tongue.create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_method(func(v): $Tongue.set_point_position(1, v), Vector2.ZERO, fly_position - $Tongue.global_position, 0.2)
	tween.tween_method(func(v): $Tongue.set_point_position(1, v), fly_position - $Tongue.global_position, Vector2.ZERO, 0.2)

	
	print("Score: " + str(score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
