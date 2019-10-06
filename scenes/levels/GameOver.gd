extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene($"/root/state_manager".current_level)