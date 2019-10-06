extends Node

var enabled

# Called when the node enters the scene tree for the first time.
func _ready():
	set_enabled(false)
	pass # Replace with function body.

func get_enabled():
	return enabled

func set_enabled(value):
	enabled = value
	
	if value:
		for child in get_children():
			child.enable()
	else:
		for child in get_children():
			child.disable()
