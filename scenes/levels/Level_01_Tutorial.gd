extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player_enters_help_trigger(body_id, body, body_shape, area_shape):
	
	var cursor_boy = get_node("CursorBoy")
	
	if cursor_boy == body:
		print("player entered")
	
	pass # Replace with function body.
