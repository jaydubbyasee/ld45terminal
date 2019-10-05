extends KinematicBody2D

onready var projectile_scene = preload("res://Projectile.tscn")

signal player_submitted_text(text)

const GRAVITY = 9.8
const MOVEMENT_SPEED = 100
const JUMP_VELOCITY = 200
const FALL_MULTIPLIER = 10
const MAX_FALL_VELOCITY = 300
const HANG_ACCEL = 200

enum CURSOR_MODE {
	insert,
	normal
}

var _velocity = Vector2(0,0)
var _is_jumping = false
var _mode = CURSOR_MODE.normal

func _ready():
	$AnimatedSprite.play("default")

func _physics_process(delta):

	if _mode != CURSOR_MODE.insert:

		if _velocity.y > 0:
			_velocity.y += GRAVITY * FALL_MULTIPLIER
		else:
			_velocity.y += GRAVITY
#
		if Input.is_action_pressed("ui_left") && ! Input.is_action_pressed("ui_right"):
			_velocity.x = -MOVEMENT_SPEED	
		elif Input.is_action_pressed("ui_right") && ! Input.is_action_pressed("ui_left"):
			_velocity.x = MOVEMENT_SPEED
		else:
			_velocity.x = 0

		if Input.is_action_just_pressed("ui_up") && ! _is_jumping:
			_is_jumping = true
			_velocity.y = -JUMP_VELOCITY
			# Start jump timer. While this timer is in progress, we can enable hangtime by holding jump
			$JumpTimer.start(1)
		
		# Add hangtime if we're still in the first phase of the jump
		if Input.is_action_pressed("jump") && ! $JumpTimer.is_stopped():
			_velocity.y -= HANG_ACCEL * delta
		
		# If we release the jump button while the jump timer is ac
		if Input.is_action_just_released("jump") && ! $JumpTimer.is_stopped():
			$JumpTimer.stop()
			
		if Input.is_action_just_pressed("shoot"):
			var projectile = projectile_scene.instance()
			projectile.position = get_global_position()
			get_parent().add_child(projectile)
			
		if Input.is_action_just_pressed("ui_accept"):
			print("entering insert mode")
			_mode = CURSOR_MODE.insert
			# Make textbox visibile
			$LineEdit.visible = true
			$LineEdit.grab_focus()
		
		# Clamp max fall velocity
		_velocity.y = min(_velocity.y, MAX_FALL_VELOCITY)
			
		move_and_slide(_velocity, Vector2(0, -1))
	else:
		if Input.is_action_just_pressed("ui_accept"):
			# Notify listeners and flush buffer
			emit_signal("player_submitted_text", $LineEdit.text)
			$LineEdit.visible = false
			$LineEdit.text = ""
			_mode = CURSOR_MODE.normal

	if is_on_floor():
		_is_jumping = false
