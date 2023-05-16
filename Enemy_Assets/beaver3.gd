extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var sprite : AnimatedSprite2D = $AnimatedBeaver
@onready var timer : Timer = $DamagedTimer
@export var player : Player

#@export var terry : Player = $Terry

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.RIGHT
var damaged = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if velocity.x == 0:
		velocity.x = direction.x * SPEED
		direction.x = -1 * direction.x

	if damaged:
		update_animation()
		move_and_slide()
		update_damaged()
	else:
		move_and_slide()
		update_dir()
		update_animation()
		update_damaged()
		

func update_dir():
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func update_animation():
	if timer.is_stopped():
		sprite.play("walking")
	else:
		sprite.play("damaged")
		
func update_damaged():
	if timer.is_stopped():
		damaged = false
	else:
		damaged = true


func _on_hit_box_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.name == "Terry":
		player.hearts -= 1
