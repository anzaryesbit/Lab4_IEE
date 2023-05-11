extends State

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var timer : Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped():
		next_state = return_state
		playback.travel(return_animation_node)

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "attack"):
		next_state = return_state
		playback.travel(return_animation_node)

