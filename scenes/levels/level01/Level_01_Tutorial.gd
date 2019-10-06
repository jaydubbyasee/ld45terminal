extends Node2D

func _ready():
	$"/root/state_manager".current_level = "res://scenes/levels/level01/Level_01_Tutorial.tscn"

var help_entered = false
func _on_player_enters_help_trigger(body_id, body, body_shape, area_shape):
	if $CursorBoy == body:
		print_debug("player entered")
		help_entered = true
	pass

func _on_help_trigger_exited(body_id, body, body_shape, area_shape):
	if $CursorBoy == body:
		print_debug("player exited")
		help_entered = false
	pass

var command_trigger_entered = false
func _on_CommandsTrigger_body_shape_entered(body_id, body, body_shape, area_shape):
	if $CursorBoy == body:
		command_trigger_entered = true
	pass

func _on_CommandsTrigger_body_shape_exited(body_id, body, body_shape, area_shape):
	if $CursorBoy == body:
		command_trigger_entered = false
	pass

func _on_CursorBoy_player_submitted_text(text):
	if help_entered:
		match text:
			"/h", "/help":
				$HelpGroup.enable()
	if command_trigger_entered:
		match text:
			"ls":
				$FileGroup.enable()
	if level_trigger_entered:
		match text:
			"open":
				get_tree().change_scene("res://scenes/levels/level02/Level_02.tscn")

var level_trigger_entered = false
func _on_Level2Trigger_body_shape_entered(body_id, body, body_shape, area_shape):
	if body == $CursorBoy:
		level_trigger_entered = true
	pass


func _on_Level2Trigger_body_shape_exited(body_id, body, body_shape, area_shape):
	if $CursorBoy == body:
		level_trigger_entered = false
	pass


func _on_WorldBounds_body_exited(body):
	if body == $CursorBoy:
		$CursorBoy.die()
	pass


func _on_CameraTransitionTrigger01_body_entered(body):
	if body == $CursorBoy:
		print("entered camera trans")
		var camera = $Cameras/Camera
		var camera_hint = $Cameras/CameraHint01
		$Tween.interpolate_property(camera, "position", camera.position, camera_hint.position, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
	pass


func _on_DeathTimer_timeout():
	get_tree().change_scene("res://scenes/levels/GameOver.tscn")
	pass
