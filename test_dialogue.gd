extends CanvasLayer

var dialogue = []
var data_path = "res://dialogue/test.json"
var current_dialogue_id = 0
var d_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect.visible = false

func start():
	if d_active:
		print("in here")
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_json()
	
	$NinePatchRect/Name.text = dialogue[-1]['name']
	$NinePatchRect/Chat.text = dialogue[-1]['text']
	next_script()
	

func load_json():
	if FileAccess.file_exists(data_path):
		var dataFile = FileAccess.open(data_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
	
		return parsedResult
	else:
		print("File doesn't exist")

func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("interact"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		$Timer.start()
		$NinePatchRect.visible = false
		current_dialogue_id = 0
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Chat.text = dialogue[current_dialogue_id]['text']
	
	

func _on_timer_timeout():
	d_active = false
