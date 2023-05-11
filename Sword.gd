extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(1)
	
	print(body.name)
