extends Area2D


@export var player : CharacterBody2D
@export var facing_collision_shape : FacingCollisionShape



# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(1)
			var enemy = child.get_parent()
			print("terry:", player.global_position.x, "--- enemy:", enemy.global_position.x)
			if player.global_position.x < enemy.global_position.x:
#				enemy.position.x += 15
				enemy.set_velocity(Vector2(200, -100))
			else:
#				enemy.position.x -= 15
				enemy.set_velocity(Vector2(-200, -100))
	
	print(body.name)

func _on_player_facing_direction_changed(facing_right):
	if facing_right:
		facing_collision_shape.position =  facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
