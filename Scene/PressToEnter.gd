extends Node

var audioscene

# Called when the node enters the scene tree for the first time.
func _ready():
	audioscene = get_node("/root/AudioScene")
	if (OS.get_name() == "Web"):
		audioscene.StopMusic()
	else:
		get_tree().change_scene_to_file("res://Scene/Menu.tscn")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	audioscene.ChangeMusic(AudioScene.Music.Menu)
	audioscene.StartMusic()
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")
