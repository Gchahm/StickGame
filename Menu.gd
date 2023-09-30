extends Control

var audioscene

# Called when the node enters the scene tree for the first time.
func _ready():
	audioscene = get_node("/root/AudioScene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	audioscene.ChangeMusic(AudioScene.Music.Game)
	audioscene.StartMusic()
	audioscene.StartAmbientSounds()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_options_pressed():
	#audioscene.Slurp()
	get_tree().change_scene_to_file("res://Scene/Settings.tscn")


func _on_quit_pressed():
	get_tree().quit()


