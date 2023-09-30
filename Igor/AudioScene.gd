extends Node2D

class SoundObject:
	var _audioStream
	
	func _init(audioStream):
		_audioStream = audioStream
	
	func Stop():
		_audioStream.stop()

var _minFlyPitch = 0.75
var _maxFlyPitch = 1.25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

enum SoundType {
	Slurp,
	Snack,
	Fly
}

enum Music {
	Menu,
	Game
}
	

func PlaySound(soundType, parentObject, speed = 0.5):
	var playerToUse
	var pitchScale = 1.0
	
	match soundType:
		SoundType.Slurp:
			playerToUse = $Slurp
		SoundType.Snack:
			playerToUse = $Snack
		SoundType.Fly:
			playerToUse = $Fly
			pitchScale = _minFlyPitch + ((_maxFlyPitch - _minFlyPitch) * speed)
	
	var newAudioStreamPlayer = playerToUse.duplicate()
	var soundObject = SoundObject.new(newAudioStreamPlayer)
	parentObject.add_child(soundObject._audioStream)

	if (newAudioStreamPlayer is AudioStreamPlayer2D):
		newAudioStreamPlayer.transform = parentObject.transform

	newAudioStreamPlayer.pitchScale = pitchScale
	newAudioStreamPlayer.play()
	newAudioStreamPlayer.finished.connect(queue_free.bind(newAudioStreamPlayer))
	return soundObject

func ChangeMusic(music):
	match music:
		Music.Menu:
			$Music.stream = load("res://Igor/menu.mp3")
		Music.Game:
			$Music.stream = load("res://Igor/gameplay.mp3")

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
