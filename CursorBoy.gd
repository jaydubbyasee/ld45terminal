extends KinematicBody2D

onready var projectile_scene = preload("res://Projectile.tscn")

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

func _process(delta):
	if Input.is_action_just_pressed("insert_mode") && _mode != CURSOR_MODE.insert:
		print("entering insert mode")
		_mode = CURSOR_MODE.insert
		# Make textbox visibile
		$LineEdit.visible = true
		$LineEdit.grab_focus()
	pass

func _physics_process(delta):

	if _mode != CURSOR_MODE.insert:

		if _velocity.y > 0:
			_velocity.y += GRAVITY * FALL_MULTIPLIER
		else:
			_velocity.y += GRAVITY
		
		# Requirements:
		# If left is pressed, move left
		# If right is pressed, move right
		# If both are pressed, move the most recent pressed
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
		
		# Clamp max fall velocity
		_velocity.y = min(_velocity.y, MAX_FALL_VELOCITY)
			
		move_and_slide(_velocity, Vector2(0, -1))
	else:
		if Input.is_action_just_pressed("ui_accept"):
			print("exiting insert mode")
			_mode = CURSOR_MODE.normal
			# TODO: FLUSH buffer and hide text edit
			$LineEdit.visible = false
			$LineEdit.text = ""
		else:
			print ("insert mode")

	if is_on_floor():
		_is_jumping = false
