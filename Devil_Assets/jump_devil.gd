extends Devil

var can_interact = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dialogue = null

func _ready():
	dialogue = get_node("Dialogue")
	
func _process(delta):
	if dialogue.talked_to == true:
		accepted_deal = true
	
func _on_interactable_area_body_entered(body):
	print(body.name)
	if body.name == "Terry":
		$Label.visible = true
		can_interact = true


func _on_interactable_area_body_exited(body):
	if body.name == "Terry":
		$Label.visible = false
		can_interact = false
		

func _input(event):
	if Input.is_key_pressed(KEY_E) and can_interact:
		$Label.visible = false
		use_dialogue()

func use_dialogue():
	dialogue.data_path = "res://dialogue/jump_dialogue.json"
	if dialogue:
		dialogue.start()

## check if we made a deal
#if get_parent().get_node("Devil").accepted_deal == false:
#	print("yay")

