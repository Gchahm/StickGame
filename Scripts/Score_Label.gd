extends Label

var score: int = 100
# Called when the node enters the scene tree for the first time.

func _on_plus_score_pressed():
	score += 10
	$".".text = str(score)


func _on_minus_score_pressed():
	score -= 10
	$".".text = str(score)
