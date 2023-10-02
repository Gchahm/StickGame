extends Node2D

class_name pair

signal hit

var flying = false
var in_hitbox = false
var is_wasp = false
var rand = RandomNumberGenerator.new()
var GRAVITY = 0.8
var bonus_gravity = 0
var air_time = 0.0
var soundObject

var glowMaterial = CanvasItemMaterial.new()
var glowSprite : AnimatedSprite2D
var glowSpriteTween : Tween

func _ready() -> void:
	$fly/AnimatedSprite2D.play("bug")
	$Bush.play("default")
	glowMaterial.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	glowSprite = $fly/AnimatedSprite2D.duplicate()
	glowSprite.play("bug")
	$fly.add_child(glowSprite)
	glowSprite.show_behind_parent = true
	glowSprite.modulate = Color(0.2, 1, 0.2)
	glowSprite.material = glowMaterial
	glowSprite.modulate.a = 0.0

func increase_level():
	GRAVITY += 1

func reset_fly():
	
	flying = false
	$fly/AnimatedSprite2D.stop()
	
	await Juice.flash($fly).finished

	
	is_wasp = rand.randf() <= 0.25
	$fly.position = Vector2.ZERO
	if is_wasp:
		$fly/AnimatedSprite2D.play("wasp")
		glowSprite.modulate = Color(1, 0.2, 0.2, 0)
	else:
		$fly/AnimatedSprite2D.play("bug")
		glowSprite.modulate = Color(0.2, 1, 0.2, 0)
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
	glowSprite.modulate.a = 0.9
	glowSpriteTween = glowSprite.create_tween()
	glowSpriteTween.tween_property(glowSprite, "scale", Vector2(1.3, 1.3), 0.1)


func _on_hit_box_area_exited(area):
	in_hitbox = false
	glowSpriteTween.tween_property(glowSprite, "scale", Vector2(1.0, 1.0), 0.05)
	glowSprite.modulate.a = 0.0
	#$fly/AnimatedSprite2D.remove_child(glowSprite)
	#glowSprite.queue_free()
	#glowSprite = null

