extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var sprite : AnimatedSprite2D = $AnimatedBoss
@onready var timer : Timer = $DamagedTimer
@export var player : Player
@export var walk_dist : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.RIGHT
var damaged = false

var talked = false
var talking = false
var fighting = false
var can_interact = false
var dialogue = null

var start_pos
var end_pos

func _ready():
	dialogue = get_node("Dialogue")
	start_pos = position
	end_pos = start_pos + walk_dist

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	if not talked or talking:
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
#		if velocity.x == 0:
#			velocity.x = direction.x * SPEED
#			direction.x = -1 * direction.x
		move()
		move_and_slide()
#		update_dir()
		update_animation()
		update_damaged()
		


func update_dir():
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func update_animation():
	if dialogue.d_active == false:
		talking = false
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

func move():
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
	dialogue.data_path = "res://dialogue/boss_dialogue.json"
	talked = true
	talking = true
	if dialogue:
		dialogue.start()


func _on_hit_box_body_entered(body):
	if body.name == "Terry" && talked:
		player.hearts -= 1
