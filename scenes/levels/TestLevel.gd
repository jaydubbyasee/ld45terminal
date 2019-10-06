extends Node2D

onready var cursor_scene = preload("res://CursorBoy.tscn")

func _ready():
	$CursorBoy.die()

func _on_death(body):
	get_tree().change_scene("res://scenes/levels/GameOver.tscn")
	pass
