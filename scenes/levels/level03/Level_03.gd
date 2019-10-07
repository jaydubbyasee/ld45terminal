extends Node2D

# var vis_groups = ["preOpenAsset", "assetGroup", "safeGroup"]
var curr_vis_group = "preOpenAsset"
var file_generated = false
var level_change_trigger = false

func _ready():
	$"/root/state_manager".current_level = "res://scenes/levels/level03/Level_03.tscn"
	get_tree().call_group("hideOnStart", "disable")
	get_tree().call_group("hideOnStart", "set_visible", false)
	get_tree().call_group("hideOnStart", "set_disabled", true)
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
			set_enabled_group(curr_vis_group, true)
		"clear":
			set_enabled_group("clearable", false)
		"open":
			if $Triggers/AssetHighlight.visible:
				set_enabled_group("assetGroup", true)
				curr_vis_group = "assetGroup"
			if level_change_trigger:
				# get_tree().change_scene("res://scenes/levels/level03/Level_03.tscn")
				print("TODO: change to level 4")
	pass

func set_enabled_group(group, enable):
	if enable:
		get_tree().call_group(group, "enable")
	else:
		get_tree().call_group(group, "disable")
		
	get_tree().call_group(group, "set_disabled", !enable)

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
	pass

func _on_AssetTrigger_body_entered(body):
	if body == $CursorBoy && $Platforms/AssetsGroup/AssetsFolderPlatform.enabled:
		$Triggers/AssetHighlight.visible = true


func _on_AssetTrigger_body_exited(body):
	if body == $CursorBoy:
		$Triggers/AssetHighlight.visible = false
