extends Node2D

signal box_pressed

var labels = []
var label_text_codes = [0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():
	labels.append($Label1)
	labels.append($Label2)
	labels.append($Label3)
	labels.append($Label4)
	labels.append($Label5)
	labels.append($Label6)

	for i in range(len(labels)):
		var text = str(i + 1)
		update_box(i, text)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if 'keycode' in event and 'pressed' in event and event.pressed:
		if event.keycode in label_text_codes:
			var box_index = label_text_codes.find(event.keycode)
			emit_signal("box_pressed", box_index)

func update_box(index, value):
	labels[index].text = value
	label_text_codes[index] = value.to_ascii_buffer()[0]
