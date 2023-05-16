extends CharacterBody2D
class_name Player

signal life_changed(player_hearts)
signal facing_direction_changed(facing_right : bool)

var max_hearts = 10
var hearts = 10

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var animation_tree : AnimationTree = $AnimationTree
var direction : Vector2 = Vector2.ZERO
var animation_locked : bool = false
var in_air : bool = false

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _ready():
	animation_tree.active = true
	
func _process(_delta):
	if max_hearts <= hearts:
		hearts = max_hearts
	if hearts == 0:
		game_over()
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		in_air = true
	else:
		if in_air == true:
			land()
		in_air = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation()
	update_facing_direction()
	move_and_slide()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	
		
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)

func land():
	#animated_sprite.play("fall")
	animation_locked = false

func jump():
	velocity.y = JUMP_VELOCITY
	# animated_sprite.play("jump")
	animation_locked = true

func attack():
	# animated_sprite.play("attack")
	pass
	
func get_health():
	return hearts

func game_over():
	get_tree().change_scene_to_file("res://game_over_screen.tscn")

#func _on_player_hitbox_body_entered(_body):
#	hearts -= 1
#	#$Control/Hearts.set_size(Vector2(hearts * 32, 32))
#	if (hearts <= 0):
#		print("You died")

