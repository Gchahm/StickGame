extends Node
class_name Juice

static func squish(node:Node2D):
	var tween = node.create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "scale", Vector2.ONE * 0.9, 0.1)
	tween.tween_property(node, "scale", Vector2.ONE, 0.1)

static func flash(node:Node2D, count:int = 1):
	var tween = node.create_tween()
	for i in count:
		tween.tween_property(node, "modulate", Color(100, 100, 100, 100), 0)
		tween.tween_property(node, "modulate", Color.WHITE, 0).set_delay(0.1)
		tween.tween_property(node, "modulate", Color.WHITE, 0).set_delay(0.1)
		
	return tween
