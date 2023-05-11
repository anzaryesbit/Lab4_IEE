extends RichTextLabel

var t = Texture.new()
@export var character : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t = load("res://Heart_1.png")
	add_image(t, 32, 20)
