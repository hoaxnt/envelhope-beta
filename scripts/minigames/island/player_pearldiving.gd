extends CharacterBody2D


var speed : int =  80
var speed_up : int = 20
var slow_down : int = 6


func _ready() -> void:
	pass
	
	
func move_state() -> void:
	var move_vector :  Vector2 = Vector2(1, 1)
	
	move_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	print(move_vector)
	
	if move_vector != Vector2.ZERO:
		velocity = velocity.move_toward(move_vector*speed, speed_up)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, slow_down)
		
	move_and_slide()
	
func _physics_process(delta):
	move_state()

func player():
	pass
