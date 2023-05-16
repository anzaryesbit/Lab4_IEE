extends CharacterBody2D

var can_interact = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var accepted_deal : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


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
	var dialogue = get_node("Dialogue")
	if dialogue:
		dialogue.start()

## check if we made a deal
#if get_parent().get_node("Devil").accepted_deal == false:
#	print("yay")
