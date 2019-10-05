extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	disable()
	pass # Replace with function body.

func enable():
	for child in get_children():
		child.enable()
	
func disable():
	for child in get_children():
		child.disable()