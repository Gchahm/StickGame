extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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

func Eat():
	$Slurp.play() 
