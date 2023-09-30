extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func PauseMusic():
	$AudioStreamPlayer.stream_paused = true

func ResumeMusic():
	$AudioStreamPlayer.stream_paused = false
	
func StartMusic():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.stream_paused = false

func Eat():
	$Slurp.play()
