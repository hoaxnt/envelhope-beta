extends CharacterBody2D

const SPEED = 50.0 

@export var player: Node2D 
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func make_path():
	nav_agent.target_position = player.global_position
		
func _physics_process(_delta: float):
	var next_point = nav_agent.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_point)

	velocity = direction * SPEED
	move_and_slide()

func _on_timer_timeout() -> void:
	make_path()
