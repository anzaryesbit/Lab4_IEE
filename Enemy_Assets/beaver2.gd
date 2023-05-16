extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var animated = false

@onready var sprite : AnimatedSprite2D = $AnimatedBeaver
@onready var timer : Timer = $DamagedTimer
@export var walk_dist : Vector2

var start_pos
var end_pos

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	start_pos = position
	end_pos = start_pos + walk_dist


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	if global_position.x <= start_pos.x:
		velocity.x = SPEED
		sprite.flip_h = true
	elif global_position.x >= end_pos.x:
		velocity.x = -1 * SPEED
		sprite.flip_h = false
		
	if velocity.x == 0:
		if sprite.flip_h == true:
			sprite.flip_h = false
			velocity.x = -1 * SPEED
		else:
			sprite.flip_h = true
			velocity.x = SPEED


#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	if timer.is_stopped():
		move_and_slide()
		update_animation()
	else:
		update_animation()
	

func update_animation():
	if timer.is_stopped():
		sprite.play("idle")
	else:
		sprite.play("damaged")


