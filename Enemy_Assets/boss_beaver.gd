extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var sprite : AnimatedSprite2D = $AnimatedBoss
@onready var timer : Timer = $DamagedTimer
@export var player : Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.RIGHT
var damaged = false

var talked = true
var talking = false
var fighting = false
var can_interact = false
var dialogue = null

func _ready():
	dialogue = get_node("Dialogue")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	if not talked:
		update_animation()
		move_and_slide()
		update_dir()
		if damaged:
			update_animation()
			move_and_slide()
			update_damaged()
	elif damaged:
		update_animation()
		move_and_slide()
		update_damaged()
	else:
		if velocity.x == 0:
			velocity.x = direction.x * SPEED
			direction.x = -1 * direction.x
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
		if fighting:
			sprite.play("fight")
		elif talking:
			sprite.play("smoking_talking")
		elif talked:
			sprite.play("walking")
		else:
			sprite.play("smoking")
	else:
		sprite.play("damaged")
		
func update_damaged():
	if timer.is_stopped():
		damaged = false
	else:
		damaged = true


func _on_interactable_area_body_entered(body):
	print(body.name)
	if body.name == "Terry":
		$Label.visible = true
		can_interact = true


func _on_interactable_area_body_exited(body):
	if body.name == "Terry":
		$Label.visible = false
		can_interact = false
		

func _input(_event):
	if Input.is_key_pressed(KEY_E) and can_interact:
		$Label.visible = false
		use_dialogue()

func use_dialogue():
	dialogue.data_path = "res://dialogue/enemy_dialogue.json"
	talked = true
	if dialogue:
		dialogue.start()


func _on_hit_box_body_entered(body):
	if body.name == "Terry" && talked:
		player.hearts -= 1
