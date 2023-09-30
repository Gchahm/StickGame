extends Node2D

var tween
var color_tween

func _ready():
	$Sprite2D.set_self_modulate(Color(0, 0, 0, 1))

func set_text(value):
	$Sprite2D/Label.text = value

func pressed(is_hit):
	run_click_animation()
	if is_hit:
		animate_hit()
	else:
		pass


func animate_hit():
	run_click_animation()
	if color_tween:
		color_tween.kill()
	color_tween = create_tween()
	color_tween.set_ease(Tween.EASE_IN_OUT)
	color_tween.tween_property($Sprite2D, "self_modulate", Color(231, 173, 36, 1), 0.1)
	color_tween.tween_property($Sprite2D, "self_modulate", Color(0, 0, 0, 1), 0.4)
	
	
func animate_failure():
	pass

func run_click_animation():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.bind_node($Sprite2D)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "scale", Vector2.ONE * 0.85, 0.1)
	tween.tween_property($Sprite2D, "scale", Vector2.ONE * 1, 0.4)
