extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 1

var velocity = Vector3()
var direction = Vector3()

# Walk Variables
var gravity = -9.8 * 3
const MAX_SPEED = 30
const MAX_RUNNING_SPEED = 60
const ACCEL = 3
const DEACCEL = 6

# Jumping
var jump_height = 15
var jump_max = 2
var jump_count = 0

var messages = [
	"Got one!",
	"How many more?",
	"It's slippery around here",
	"What happens if I fall?",
	"Am I light or very strong?",
	"Only a few more I hope",
	"Easy enough",
	"Slap that sub button gamers"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player_position = Vector3.ZERO
	Global.player_rotation = null
	
func lerpp(A, B, F):
	return B + (A - B) * F
	
func _physics_process(delta):
	# Reset the direction of the player
	direction = Vector3()
	
	var aim = $Head/Camera.get_global_transform().basis
	
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z 
	if Input.is_action_pressed("move_back"):
		direction += aim.z 
	if Input.is_action_pressed("move_left"):
		$Head.rotate_y(deg2rad(200 * delta))
		get_parent().get_node("CanvasLayer/Node2D").rotation_degrees = lerpp(get_parent().get_node("CanvasLayer/Node2D").rotation_degrees, -6, .8)
	elif Input.is_action_pressed("move_right"):
		$Head.rotate_y(deg2rad(-200 * delta))	
		get_parent().get_node("CanvasLayer/Node2D").rotation_degrees = lerpp(get_parent().get_node("CanvasLayer/Node2D").rotation_degrees, 6, .8)
	else:
		get_parent().get_node("CanvasLayer/Node2D").rotation_degrees = lerpp(get_parent().get_node("CanvasLayer/Node2D").rotation_degrees, 0, .8)
	direction = direction.normalized()
	
	velocity.y += gravity * delta
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed = MAX_SPEED
		
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if self.is_on_floor():
		jump_count = 0
		
	if (self.translation.y < -60):
		get_parent().get_node("CanvasLayer/Node2D/Label").display_self("We're dying")
		
	if (self.translation.y < -200):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		
	if Input.is_action_just_pressed("jump"):
		if jump_count < jump_max:
			velocity.y = jump_height
			jump_count += 1
		else:
			get_parent().get_node("CanvasLayer/Node2D/Label").display_self("No more jumps!")
		
	if (Input.is_action_just_pressed("turn")):
		if (Global.player_position == Vector3.ZERO):
			Global.player_position = self.translation
			Global.player_rotation = $Head.rotation_degrees
			get_parent().get_node("CanvasLayer/Node2D/Label").display_self("Teleport Point Set")
		else:
			self.translation = Global.player_position
			$Head.rotation_degrees = Global.player_rotation
			Global.player_position = Vector3.ZERO
			Global.player_rotation = null
			get_parent().get_node("CanvasLayer/Node2D/Label").display_self("Teleport Used")
			
func cube_message():
	messages.shuffle()
	var m = messages.pop_front()
	get_parent().get_node("CanvasLayer/Node2D/Label").display_self(m)
		
			
			


