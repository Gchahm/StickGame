extends Node2D

signal hit

var flying = false
var in_hitbox = false
var is_wasp = false
var rand = RandomNumberGenerator.new()
const GRAVITY = 9.8
var bonus_gravity = 0
var air_time = 0.0
var soundObject

func _ready() -> void:
	$fly/AnimatedSprite2D.play()

func reset_fly():
	is_wasp = rand.randf() <= 0.25
	$fly.position = Vector2.ZERO
	if is_wasp:
		$fly.modulate = Color.CRIMSON
	else:
		$fly.modulate = Color.WHITE
	flying = false
	soundObject.Stop()

func start_sound():
	if (soundObject != null):
		soundObject.Stop()
	soundObject = AudioScene.PlaySound(AudioScene.SoundType.Fly, $fly, rand.randf_range(0.0, 1.0))

func _process(delta):
	if flying:
		air_time += delta
		#$fly.position.y += 5
		$fly.position.y += (GRAVITY * air_time * air_time * bonus_gravity) * delta
		

func _on_box_area_entered(area):
	if !is_wasp:
		hit.emit()
	air_time = 0.0
	reset_fly()


func _on_hit_box_area_entered(area):
	in_hitbox = true


func _on_hit_box_area_exited(area):
	in_hitbox = false
