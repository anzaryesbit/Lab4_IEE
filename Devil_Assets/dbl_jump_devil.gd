extends Devil

var can_interact = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dialogue = null
var count = 0

func _ready():
	dialogue = get_node("Dialogue")
	$AnimatedSprite2D.flip_h = true
	
func _process(_delta):
	if dialogue.talked_to == true:
		count += 1
		accepted_deal = true
		if count == 1:
			get_parent().get_node("Terry").max_hearts -= 1
		
	
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

func initial_use_dialogue():
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/test.dialogue"), "start")

func use_dialogue():
	dialogue.data_path = "res://dialogue/double_jump_dialogue.json"
	if dialogue:
		dialogue.start()

## check if we made a deal
#if get_parent().get_node("Devil").accepted_deal == false:
#	print("yay")

