extends Node2D

signal hit
var flying = false

func reset_fly():
	$fly.position = Vector2.ZERO
	flying = false
	
func _process(delta):
	if flying:
		$fly.position.y += 5

func _on_box_area_entered(area):
	hit.emit()
	reset_fly()
