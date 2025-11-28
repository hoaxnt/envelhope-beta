extends CharacterBody2D

const SPEED = 101.0 #fortest

@onready var player = get_node("/root/Chapter2/Player")
@onready var police_body = $PoliceBody/Shadow
@onready var pb = get_node("/root/Chapter2/Police")

func make_path():
	if player:
		police_body.target_position = player.global_position

func _physics_process(_delta: float):

	var next_point = police_body.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_point)
	velocity = direction * SPEED
	
	print(pb.transform.origin)

	#if transform.x < 0:
		#scale.x = -1 * abs(scale.y) 
	#elif velocity.x > 0:
#
		#scale.x = abs(scale.y) 
	
	move_and_slide()

#func _physics_process(_delta: float):
	#var next_point = police_body.get_next_path_position()
	#var direction: Vector2 = global_position.direction_to(next_point)
	#velocity = direction * SPEED
	#
	#if velocity.x < 0:
		#scale.x = -1
	#else:
		#scale.x = 1
	#
	#move_and_slide()

func _on_timer_timeout() -> void:

	make_path()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
		Hud.hide()
		Transition.transition_to_scene("res://scenes/stories/caught_story.tscn")
