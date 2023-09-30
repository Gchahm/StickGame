extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_volume_db(0, 50)
	print (AudioServer.get_bus_volume_db(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scene/main_score.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scene/Settings.tscn")


func _on_quit_pressed():
	get_tree().quit()


