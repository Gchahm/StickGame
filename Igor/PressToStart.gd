extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	if (OS.get_name() == "Web"):
		AudioScene.StopMusic()
	else:
		_on_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	AudioScene.ChangeMusic(AudioScene.Music.Menu)
	AudioScene.StartMusic()
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")
