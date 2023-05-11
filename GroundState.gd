extends State
class_name GroundState

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var attack_state : State
@export var attack_animation : String = "attack"

# velocity.y = jump_velocity
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("attack")):
		attack()

func jump():
	character.velocity.y = JUMP_VELOCITY
	next_state = air_state
	playback.travel(jump_animation)
	
func attack():
	next_state = attack_state
	playback.travel(attack_animation)
