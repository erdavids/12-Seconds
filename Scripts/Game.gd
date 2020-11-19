extends Spatial

var collected = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	$DeathTimer.set_wait_time(12)
	$DeathTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#get_tree().quit()
	if Input.is_action_just_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		#get_tree().quit()
		
	get_node("CanvasLayer/Node2D/Timer").value = int($DeathTimer.time_left * 10)
	
	if (len(get_node("Collects").get_children()) <= 0):
		get_tree().change_scene("res://Scenes/End.tscn")


func _on_DeathTimer_timeout():
	# Put death screen here
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
