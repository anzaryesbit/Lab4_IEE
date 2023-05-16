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
func _process(_delta):
	if timer.is_stopped():
		next_state = return_state
		playback.travel(return_animation_node)



