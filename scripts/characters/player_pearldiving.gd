extends CharacterBody2D

@onready var timer_label = get_node("/root/JunkDiving/CanvasLayer/TimerLabel")
@export var player_sprite : AnimatedSprite2D

const SPEED = 300.0#fortest
const ACCELERATION = 100.0

func _physics_process(delta: float) -> void:
	
	if get_parent().game_started:
		var input_x := Input.get_axis("ui_left", "ui_right")
		var input_y := Input.get_axis("ui_up", "ui_down")
		var input_vector := Vector2(input_x, input_y).normalized()
		var target_velocity := input_vector * SPEED
		
		if input_x > 0:
			player_sprite.scale.x = abs(player_sprite.scale.x)
		elif input_x < 0:
			player_sprite.scale.x = -abs(player_sprite.scale.x)
		
		velocity.x = lerp(velocity.x, target_velocity.x, ACCELERATION * delta)
		velocity.y = lerp(velocity.y, target_velocity.y, ACCELERATION * delta)
		move_and_slide()

func on_hit_obstacle() -> void:
		print("CROCS BITE")
		get_parent().TIME -= 10
