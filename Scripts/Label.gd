extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func display_self(display):
	text = display
	visible = true
	$Timer.one_shot = true
	$Timer.set_wait_time(1)
	$Timer.start()
	
	

func _on_Timer_timeout():
	visible = false
