extends CharacterBody2D

const SPEED = 70.0 

@onready var player = get_node("/root/Chapter2/Player")
@onready var poice_body = $PoliceBody/Shadow

func make_path():
	if player:
		poice_body.target_position = player.global_position
		
func _physics_process(_delta: float):
	var next_point = poice_body.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_point)
	velocity = direction * SPEED
	move_and_slide()

func _on_timer_timeout() -> void:
	make_path()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Transition.transition_to_scene("res://scenes/stories/caught_story.tscn")
