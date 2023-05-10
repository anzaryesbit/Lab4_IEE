extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var sprite : AnimatedSprite2D = $AnimatedBeaver

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.RIGHT


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

	move_and_slide()
	update_dir()

func update_dir():
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
