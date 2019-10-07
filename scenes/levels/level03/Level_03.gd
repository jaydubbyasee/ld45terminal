extends Node2D

func _ready():
	$"/root/state_manager".current_level = "res://scenes/levels/level03/Level_03.tscn"
	get_tree().call_group("hideOnStart", "disable")
	get_tree().call_group("hideOnStart", "set_visible", false)
	pass

func _on_WorldBounds_body_exited(body):
	if body == $CursorBoy:
		$CursorBoy.die()
	pass

func _on_DeathTimer_timeout():
	get_tree().change_scene("res://scenes/levels/GameOver.tscn")
	pass

var file_generated = false
func _on_CursorBoy_player_submitted_text(text):
	match text:
		"/h", "/help":
			get_tree().call_group("helpPlatforms", "enable")
		"ls":
			if ! file_generated:
				$Platforms/noFilesPlatform.enable()
			else:
				$Platforms/level03Platform.enable()
		"gen_level3":
			$Platforms/level03Platform.enable()
			file_generated = true
		"clear":
			get_tree().call_group("clearable", "disable")
		"open":
			if level4_trigger:
				# get_tree().change_scene("res://scenes/levels/level03/Level_03.tscn")
				print("TODO: change to level 4")
	pass

var level4_trigger = false
func _on_Level04Trigger_body_entered(body):
	if body == $CursorBoy:
		$Level04Highlight.visible = true
		level4_trigger = true
	pass


func _on_Level04Trigger_body_exited(body):
	if body == $CursorBoy:
		$Level04Highlight.visible = false
		level4_trigger = false
	pass
