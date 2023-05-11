extends State
class_name AirState

@export var landing_state : LandingState
@export var landing_animation : String = "fall"

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state

func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
