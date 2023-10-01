extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	AudioScene.ChangeMusic(AudioScene.Music.Gameplay)
	AudioScene.StartMusic()
	AudioScene.StartAmbientSounds()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Settings.tscn")


func _on_quit_pressed():
	get_tree().quit()


