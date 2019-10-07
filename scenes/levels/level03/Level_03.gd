extends Node2D

var file_platforms = []
var file_generated = false
var level_change_trigger = false

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

var open_assets_checkpoint = false
func _on_CursorBoy_player_submitted_text(text):
	match text:
		"/h", "/help":
			get_tree().call_group("helpPlatforms", "enable")
		"ls":
			if ! open_assets_checkpoint:
				$Platforms/AssetsGroup/AssetsFolderPlatform.enable()	
		"clear":
			get_tree().call_group("clearable", "disable")
		"open":
			if level_change_trigger:
				# get_tree().change_scene("res://scenes/levels/level03/Level_03.tscn")
				print("TODO: change to level 4")
	pass


func _on_Level04Trigger_body_entered(body):
	if body == $CursorBoy:
		$Level04Highlight.visible = true
		level_change_trigger = true
	pass


func _on_Level04Trigger_body_exited(body):
	if body == $CursorBoy:
		$Level04Highlight.visible = false
		level_change_trigger = false
	pass


func _on_DeathTrigger_body_entered(body):
	if body == $CursorBoy:
		$CursorBoy.die()
	pass # Replace with function body.
