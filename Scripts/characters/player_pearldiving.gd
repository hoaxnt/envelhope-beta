extends CharacterBody2D

const SPEED = 200.0#fortest
const ACCELERATION = 50.0

func _physics_process(delta: float) -> void:
	var input_x := Input.get_axis("ui_left", "ui_right")
	var input_y := Input.get_axis("ui_up", "ui_down")
	var input_vector := Vector2(input_x, input_y).normalized()
	var target_velocity := input_vector * SPEED

	velocity.x = lerp(velocity.x, target_velocity.x, ACCELERATION * delta)
	velocity.y = lerp(velocity.y, target_velocity.y, ACCELERATION * delta)
	move_and_slide()

func on_hit_obstacle() -> void:
	#if game_manager and game_manager.game_active:
		#game_manager.deduct_time()
		print("CROCS BITE")
		pass
