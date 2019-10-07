extends Node2D

func _ready():
	$"/root/state_manager".current_level = "res://scenes/levels/level02/Level_02.tscn"
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

func _on_CursorBoy_player_submitted_text(text):
	match text:
		"/h", "/help":
			get_tree().call_group("helpPlatforms", "enable")
		"ls":
			$Platforms/noFilesPlatform.enable()
		"gen_level3":
			$Platforms/level03Platform.enable()
		"clear":
			get_tree().call_group("clearable", "disable")
		"open":
			if level3_trigger:
				get_tree().change_scene("res://scenes/levels/level03/Level_03.tscn")	
	pass

var level3_trigger = false
func _on_Level03Trigger_body_entered(body):
	if body == $CursorBoy:
		$Level03Highlight.visible = true
		level3_trigger = true
	pass


func _on_Level03Trigger_body_exited(body):
	if body == $CursorBoy:
		$Level03Highlight.visible = false
		level3_trigger = false
	pass
