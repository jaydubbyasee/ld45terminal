extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var end_time = OS.get_unix_time()

	$SessionTime.text = str(end_time - $"/root/state_manager".start_time) + "s"
	$DeathCount.text = str($"/root/state_manager".deaths)
	get_tree().call_group("hideOnStart", "set_visible", false)
	
	pass # Replace with function body.

func _unhandled_key_input(event):
	if event is InputEventKey && $PromptLabel.visible:
		if event.pressed:
			$BootTimer.start()		
			$LaunchingLabel.visible = true

func _on_BootTimer_timeout():
	# Reinitialize stats
	$"/root/state_manager".start_time = OS.get_unix_time()
	$"/root/state_manager".current_level = "res://scenes/levels/level01/Level_01_Tutorial.tscn"
	$"/root/state_manager".deaths = 0

	get_tree().change_scene($"/root/state_manager".current_level)


func _on_TextTimer1_timeout():
	$ClosingLabel.visible = true
	pass # Replace with function body.


func _on_TextTimer2_timeout():
	$SessionTimeLabel.visible = true
	$SessionTime.visible = true
	$DeathLabel.visible = true
	$DeathCount.visible = true

	pass # Replace with function body.


func _on_TextTimer3_timeout():
	$EndedLabel.visible = true
	pass # Replace with function body.


func _on_TextTimer4_timeout():
	$Thanks.visible = true
	pass # Replace with function body.


func _on_InputLockoutTimer_timeout():
	$PromptLabel.visible = true
	pass # Replace with function body.



