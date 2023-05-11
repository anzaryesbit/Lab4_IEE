extends State
class_name LandingState

@export var landing_animation_name : String = "fall"
@export var ground_state : GroundState

func _process(delta):
	if character.is_on_floor():
		next_state = ground_state
