extends RichTextLabel

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".append_text("Score: " + str(score))

## Add logic to when the Level finishes to add +1

func _on_plus_score_pressed():
	score += 10
	$".".clear()
	$".".append_text("Score: " + str(score))


func _on_minus_score_pressed():
	score -= 10
	$".".clear()
	$".".append_text("Score: " + str(score))
