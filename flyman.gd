extends Node2D

signal miss
signal catch
signal sting


var pairs = []
var timer:Timer
var delta_sum := 0.0

@export var curve:Curve

func try_catch(fly_index) -> bool:
	if fly_index >= pairs.size():
		return false
	
	if fly_index < 0:
		return false
		
	if not pairs[fly_index].flying:
		return false
	
	if pairs[fly_index].is_wasp:
		sting.emit(fly_index)
	else:
		catch.emit(fly_index)
		
	pairs[fly_index].reset_fly()
	
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count():
		var child = get_child(i)
		pairs.push_back(child)
		child.hit.connect(emit_signal.bind("miss", i))
		
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(flytime)
	timer.one_shot = true
	timer.start(curve.sample(delta_sum * 0.0005))


func flytime():
	pairs.pick_random().flying = true
	timer.start(curve.sample(delta_sum * 0.0005))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_sum += delta

