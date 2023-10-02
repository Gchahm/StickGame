extends Node2D
class_name PointPopin

func _ready():
	rotation += randf_range(-1, 1) * 0.1
	scale = Vector2.ZERO
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE * 3.0, 0.1)

	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.finished.connect(queue_free)

static func popin(parent:Node2D, pos:Vector2, str:String):
	var s = preload("res://juice/points.tscn").instantiate()
	parent.add_child(s)
	s.get_node("Label").text = str
	s.global_position = pos
