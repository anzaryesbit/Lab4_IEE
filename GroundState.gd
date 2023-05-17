extends State
class_name GroundState

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var attack_state : State
@export var attack_animation : String = "attack"

var can_jump = false
var can_attack = false


# velocity.y = jump_velocity
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		if get_parent().get_parent().get_parent().get_node("Jump_Devil").accepted_deal == true:
			jump()
	if (event.is_action_pressed("attack")):
		if get_parent().get_parent().get_parent().get_node("Attack_Devil").accepted_deal == true:
			attack()
	if !character.is_on_floor():
		next_state = air_state

func jump():
	playback.travel(jump_animation)
	character.velocity.y = JUMP_VELOCITY
	next_state = air_state
	
	
func attack():
	next_state = attack_state
	playback.travel(attack_animation)


func _on_attack_devil_property_list_changed():
	can_attack = true
