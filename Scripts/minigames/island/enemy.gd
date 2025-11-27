extends CharacterBody2D

const SPEED = 70.0 

@onready var player = get_node("/root/Chapter2/Player")
#@onready var player = get_node("/root/PoliceChase/Player")#fortest
@onready var poice_body = $PoliceBody/Shadow

func make_path():
	if player:
		print("player exist")
		poice_body.target_position = player.global_position
		
func _physics_process(_delta: float):
	var next_point = poice_body.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_point)
	velocity = direction * SPEED
	move_and_slide()

func _on_timer_timeout() -> void:
	print("timeout, make path")
	make_path()
