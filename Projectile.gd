extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(3,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("pew")
	pass # Replace with function body.

func _physics_process(delta):
	position += velocity
