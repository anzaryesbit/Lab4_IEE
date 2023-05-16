extends CharacterBody2D

class_name Devil

@export var accepted_deal : bool = false
@export var talked_to : bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _on_interactable_area_body_entered(body):
	pass

func _on_interactable_area_body_exited(body):
	pass

func _input(event):
	pass

func use_dialogue():
	pass
