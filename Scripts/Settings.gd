extends Control

func _ready():
	$MarginContainer/VBoxContainer/Music.value = 25
	$MarginContainer/VBoxContainer/Effects.value = 25

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scene/Menu.tscn")


func _on_effects_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	var adjusted_value_fx = value * 0.6
	if adjusted_value_fx < 25:
		adjusted_value_fx = 25
	elif adjusted_value_fx > 55:
		adjusted_value_fx = 55
	$MarginContainer/VBoxContainer/EffectsLabel.add_theme_font_size_override("font_size", adjusted_value_fx)
	print (adjusted_value_fx)

func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	var adjusted_value_vol = value * 0.6
	if adjusted_value_vol < 25:
		adjusted_value_vol = 25
	elif adjusted_value_vol > 50:
		adjusted_value_vol = 50
	$MarginContainer/VBoxContainer/MusicLabel.add_theme_font_size_override("font_size", adjusted_value_vol)
	print (adjusted_value_vol)

	
