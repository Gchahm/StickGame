extends Node2D

signal box_pressed
@onready var buttons = self.get_child(0).get_children()

var label_text_codes = [0,0,0,0,0,0]
# Called when the node enters the scene tree for the first time.
func _ready():

	for i in range(len(buttons)):
		var text = str(i + 1)
		update_box(i, text)
		

func _input(event):
	if 'keycode' in event and 'pressed' in event and event.pressed:
		var code_char = char(event.keycode).to_lower()
		var index = label_text_codes.find(code_char)
		if index >= 0:
			box_pressed.emit(index)
			buttons[index].pressed(true)

func update_box(index, value):
	buttons[index].set_text(value)
	label_text_codes[index] = value.to_lower()
