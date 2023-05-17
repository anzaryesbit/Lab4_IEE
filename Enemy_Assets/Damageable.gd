extends Node

class_name Damageable

@export var health : int = 5
@export var sprite : AnimatedSprite2D
@export var timer : Timer
@export var character : CharacterBody2D

func hit(damage : int):
	health -= damage
	timer.start(0)
	
	if (health <= 0):
		if character.name == "BossBeaver":
			get_tree().change_scene_to_file("res://congrats.tscn")
		get_parent().queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
