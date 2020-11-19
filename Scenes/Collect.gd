extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(5 * delta)


func _on_Area_body_entered(body):
	if (body.name == "Player"):
		body.cube_message()
		get_parent().get_parent().collected += 1
		get_parent().get_parent().get_node("DeathTimer").start()
		get_parent().remove_child(self)
		queue_free()
		
