extends Label

class_name CollidableLabel

var static_body
var collision_shape
var enabled = true

func _ready():
	static_body = StaticBody2D.new()
	collision_shape = CollisionShape2D.new()
	var rectangle = RectangleShape2D.new()
	
	rectangle.extents.x = rect_size.x / 2
	rectangle.extents.y = rect_size.y / 2
	
	collision_shape.set_shape(rectangle)
	collision_shape.position += rectangle.extents

	static_body.add_child(collision_shape)
	add_child(static_body)
	
	pass
	
func enable():
	visible = true
	collision_shape.disabled = false
	enabled = true
	pass
	
func disable():
	visible = false
	collision_shape.disabled = true
	enabled = false
	pass