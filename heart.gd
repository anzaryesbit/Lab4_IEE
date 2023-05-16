extends Area2D

@export var player : Player

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Terry":
		if player.hearts < player.max_hearts:
			player.hearts += 1
			queue_free()
