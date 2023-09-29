extends Node2D

var pairs = []
var timer:Timer
var delta_sum := 0.0

@export var curve:Curve

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		pairs.push_back(child)
		
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(flytime)
	timer.one_shot = true
	timer.start(curve.sample(delta_sum * 0.025))


func flytime():
	pairs.pick_random().flying = true
	timer.start(curve.sample(delta_sum * 0.025))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_sum += delta

