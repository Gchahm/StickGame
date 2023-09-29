extends Node2D

var labels = []
# Called when the node enters the scene tree for the first time.
func _ready():
	labels.append($Label)
	labels.append($Label2)
	labels.append($Label3)
	labels.append($Label4)
	labels.append($Label5)
	labels.append($Label6)

	for i in range(len(labels)):
		labels[i].text = str(i + 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_box(index, value):
	labels[index].text = value
