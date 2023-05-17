extends State
class_name AirState

@export var landing_state : LandingState
@export var landing_animation : String = "fall"
@export var JUMP_VELOCITY = -400.0

var has_double_jumped = false

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = landing_state
	
func state_input(event: InputEvent):
	if (event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func on_exit():
	if(next_state == landing_state):
		has_double_jumped = false
		$Landing_Sound.play()
		playback.travel(landing_animation)

func double_jump():
	character.velocity.y = JUMP_VELOCITY
	has_double_jumped = true
