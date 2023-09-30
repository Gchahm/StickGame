extends Node2D


func set_text(value):
	$Sprite2D/Label.text = value

func pressed(is_hit):
	if is_hit:
		animate_hit()
	else:
		animate_failure()


func animate_hit():
	var tween = create_tween()
	tween.bind_node($Sprite2D)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "scale", Vector2.ONE * 0.85, 0.1)
	tween.tween_property($Sprite2D, "scale", Vector2.ONE * 1, 0.4)

	
func animate_failure():
	pass
