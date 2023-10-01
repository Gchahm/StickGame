extends Node2D

var score := 0
var _lastSlurpResult = SlurpResult.None

enum SlurpResult {
	None,
	Yummy,
	Owie
}
	

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
	_lastSlurpResult = SlurpResult.None
	pass#$Controls.update_box(fly_index, randomLetterOrNumber())

func _catch(fly_index):
	score += 10
	_lastSlurpResult = SlurpResult.Yummy
	print("Catch: " + str(fly_index))

func _sting(fly_index):
	score -= 20
	# If my code is right, the second param will be the "fly" object for the relevant key
	#AudioScene.PlaySound(AudioScene.SoundType.Sting, $flyman.get_children()[fly_index].get_child(0))
	_lastSlurpResult = SlurpResult.Owie
	print("Sting: " + str(fly_index))

func _box_pressed(box_index):
	var caught = $flyman.try_catch(box_index)
	var newChamFrame = 0
	
	if (box_index < 2):
		newChamFrame = 1
	elif (box_index == 2):
		newChamFrame = 2
	
	var soundObject = AudioScene.PlaySound(AudioScene.SoundType.Slurp, null)
	# newAudioStreamPlayer.finished.connect(queue_free.bind(newAudioStreamPlayer))
	soundObject._audioStream.finished.connect(_playResultSound.bind())
	
	$Cham.frame = newChamFrame	
	$Cham/shadow.frame = newChamFrame
	
	var tonguePosition = $flyman.get_box_hit_position(box_index)
	var direction = tonguePosition - $Cham.global_position
	var angleTo = $Cham/Tongue.transform.x.angle_to(direction)
	var yScale = pow(pow(tonguePosition.x - $Cham/Tongue.global_position.x, 2) + pow(tonguePosition.y - $Cham/Tongue.global_position.y, 2), 1.0/2.0) / 42
	$Cham/Tongue.rotate(angleTo + (PI / 2))
	var tween = $Cham/Tongue.create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($Cham/Tongue, "scale", Vector2(1, yScale), 0.1)
	tween.tween_property($Cham/Tongue, "scale", Vector2.ONE, 0.1)
	
	print("Score: " + str(score))

func _playResultSound():
	match _lastSlurpResult:
		SlurpResult.Yummy:
			AudioScene.PlaySound(AudioScene.SoundType.Snack, null)
		SlurpResult.Owie:
			AudioScene.PlaySound(AudioScene.SoundType.Sting, null)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
