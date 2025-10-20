extends CharacterBody2D


const SPEED = 100.0

func _ready():
	
	pass
	
func _process(_delta):
	pass
	
func _physics_process(_delta):
	velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized() * SPEED
	move_and_slide()
