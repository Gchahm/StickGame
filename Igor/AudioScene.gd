extends Node2D

class SoundObject:
	var _audioStream
	
	func _init(audioStream):
		_audioStream = audioStream
	
	func Stop():
		if is_instance_valid(_audioStream):
			_audioStream.stop()
			_audioStream.emit_signal("finished")

const _minFlyPitch = 0.75
const _maxFlyPitch = 1.25
const _maxFliesAtOnce = 3

var _flies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

enum SoundType {
	Slurp,
	Snack,
	Fly,
	Sting
}

enum Music {
	Menu,
	Gameplay
}

func PlaySound(soundType, parentObject, speed = 0.5):
	var playerToUse
	var pitchScale = 1.0

	if parentObject != null && !("transform" in parentObject):
		parentObject = $Container
		print("Object passed in does not support positioning, assuming global")
	
	if parentObject == null:
		parentObject = $Container
	
	match soundType:
		SoundType.Slurp:
			playerToUse = $Slurp
		SoundType.Snack:
			playerToUse = $Snack
		SoundType.Sting:
			playerToUse = $Scream
		SoundType.Fly:
			playerToUse = $Fly
			pitchScale = _minFlyPitch + ((_maxFlyPitch - _minFlyPitch) * speed)
		_:
			print("SoundType '" + str(soundType )+ "' not defined")
			
	
	var newAudioStreamPlayer = playerToUse.duplicate()
	var soundObject = SoundObject.new(newAudioStreamPlayer)
	
	var shouldMute = false
	if (soundType == SoundType.Fly):
		var count = 0
		for i in range(_flies.size() - 1, -1, -1):
			var f = _flies[i]
			if f == null || f._audioStream == null || !f._audioStream.playing || f._audioStream.volume_db == linear_to_db(0):
				_flies.remove_at(i)
			else:
				count += 1
		_flies.push_back(soundObject)
		count += 1
		if (count > _maxFliesAtOnce):
			shouldMute = true
	
	parentObject.add_child(soundObject._audioStream)

	if (newAudioStreamPlayer is AudioStreamPlayer2D):
		if soundType == SoundType.Fly:
			newAudioStreamPlayer.max_distance = 1500
			newAudioStreamPlayer.attenuation = 1.8
			var offset = AudioScene.get_viewport_rect().size * Vector2(0.5, 0.5)
			newAudioStreamPlayer.transform.origin = Vector2(-parentObject.global_position.x + offset.x, 0)
		newAudioStreamPlayer.add_child($AudioPositionVisualization.duplicate())

	newAudioStreamPlayer.pitch_scale = pitchScale
	if !shouldMute:
		newAudioStreamPlayer.play()
	newAudioStreamPlayer.finished.connect(newAudioStreamPlayer.queue_free)
	return soundObject

func ChangeMusic(music):
	match music:
		Music.Menu:
			$Music.stream = load("res://Igor/Music/menu.mp3")
		Music.Gameplay:
			$Music.stream = load("res://Igor/Music/gameplay.mp3")

func PauseMusic():
	$Music.stream_paused = true

func ResumeMusic():
	$Music.stream_paused = false
	
func StartMusic():
	$Music.play()
	$Music.stream_paused = false
	
func StopMusic():
	$Music.stop()
	$Music.stream_paused = false

func StartAmbientSounds():
	$Ambience.play()
	
func StopAmbientSounds():
	$Ambience.stop()

func Slurp():
	$Slurp.play() 
