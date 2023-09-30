extends Node2D

var score: int = 100
var level: int = 1
# Called when the node enters the scene tree for the first time.


func _on_plus_score_pressed():
	score += 1000
	$ColorRect/MarginContainer/HBoxContainer/Score_Value.text = str(score)


func _on_minus_score_pressed():
	score -= 1000
	$ColorRect/MarginContainer/HBoxContainer/Score_Value.text = str(score)

func _on_game_over_pressed():
	$GameOverScreen.set_score(score)
	$GameOverScreen.set_highscore(score)
	$GameOverScreen.visible = true
	print ("game over")


func _on_plus_level_pressed():
	level += 1
	$MarginContainer/HBoxContainer/Level_Value.text = str(level)


func _on_minus_level_pressed():
	level -= 1
	$MarginContainer/HBoxContainer/Level_Value.text = str(level)
