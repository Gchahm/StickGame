extends Node2D

class_name flyman

signal miss
signal catch
signal sting


var pairs = []
var timer:Timer
var delta_sum := 0.0
var bonus_gravity = 20
const GRAVITY_INCREASE := 2

@export var curve:Curve

func try_catch(fly_index, soundObject) -> bool:
	if fly_index >= pairs.size():
		return false
	
	if fly_index < 0:
		return false
		
	if not pairs[fly_index].flying or not pairs[fly_index].in_hitbox:
		return false
	
	if pairs[fly_index].is_wasp:
		sting.emit(fly_index)
		soundObject._audioStream.finished.connect(_playStingSound.bind())
	else:
		catch.emit(fly_index)
		soundObject._audioStream.finished.connect(_playSnackSound.bind())
		
	pairs[fly_index].reset_fly()
	
	return true

func _playSnackSound():
	AudioScene.PlaySound(AudioScene.SoundType.Snack, null)

func _playStingSound():
	AudioScene.PlaySound(AudioScene.SoundType.Sting, null)

func get_fly_position(fly_index):
	if fly_index >= pairs.size():
		return false
	
	if fly_index < 0:
		return false
	
	if not pairs[fly_index].in_hitbox:
		return get_box_hit_position(fly_index)
	
	return pairs[fly_index].get_node("./fly").global_position

func get_box_hit_position(box_index):
	if box_index >= pairs.size():
		# Just so it doesn't crash
		print("Non-existing node sent")
		return Vector2(pairs[0].get_node("./HitBox").get_children()[0].global_position)
	return Vector2(pairs[box_index].get_node("./HitBox").get_children()[0].global_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count():
		var child = get_child(i)
		pairs.push_back(child)
		child.hit.connect(emit_signal.bind("miss", i))
	
	var gameScene : game = get_parent()
	gameScene.level_increased.connect(_level_increased)
	
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(flytime)
	timer.one_shot = true
	timer.start(curve.sample(delta_sum * 0.0005))

func _level_increased():
	for pair in pairs:
		pair.increase_level()

func flytime():
	var fly = pairs.pick_random()
	fly.flying = true
	fly.bonus_gravity = bonus_gravity
	fly.start_sound()
	bonus_gravity += GRAVITY_INCREASE
	timer.start(curve.sample(delta_sum * 0.0005))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_sum += delta

