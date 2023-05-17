extends Area2D

@export var player : Player
	

func _on_body_entered(body):
	if body.name == "Terry":
		if player.hearts < player.max_hearts:
			player.hearts += 1
			queue_free()
