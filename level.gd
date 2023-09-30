extends Node2D

signal hit

var flying = false
var is_wasp = false
var rand = RandomNumberGenerator.new()
const GRAVITY = 9.8
var bonus_gravity = 20
var air_time = 0.0

func reset_fly():
	is_wasp = rand.randf() <= 0.25
	$fly.position = Vector2.ZERO
	if is_wasp:
		$fly.modulate = Color.CRIMSON
	else:
		$fly.modulate = Color.WHITE
	flying = false
	
func _process(delta):
	if flying:
		air_time += delta
		#$fly.position.y += 5
		$fly.position.y += (GRAVITY * air_time * air_time * bonus_gravity) * delta
		

func _on_box_area_entered(area):
	if !is_wasp:
		hit.emit()
	air_time = 0.0
	bonus_gravity += 1
	reset_fly()
