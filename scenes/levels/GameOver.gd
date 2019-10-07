extends Node2D

func _ready():
	$"/root/state_manager".deaths += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed:
			$BootTimer.start()		
			$LaunchingLabel.visible = true

func _on_BootTimer_timeout():
	get_tree().change_scene($"/root/state_manager".current_level)
