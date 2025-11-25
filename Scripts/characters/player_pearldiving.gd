extends CharacterBody2D

var game_manager: Node2D

const SPEED = 300.0
const ACCELERATION = 20.0

func _ready() -> void:
	add_to_group("player")

	game_manager = get_parent()
	if not game_manager or not game_manager.has_method("deduct_time"):
		push_error("Player could not find the Main Game Manager or the 'deduct_time' method.")

func _physics_process(delta: float) -> void:
	if game_manager and game_manager.game_active:
		var input_x := Input.get_axis("ui_left", "ui_right")
		var input_y := Input.get_axis("ui_up", "ui_down")

		var input_vector := Vector2(input_x, input_y).normalized()

		var target_velocity := input_vector * SPEED

		velocity.x = lerp(velocity.x, target_velocity.x, ACCELERATION * delta)
		velocity.y = lerp(velocity.y, target_velocity.y, ACCELERATION * delta)

		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()


func on_hit_obstacle() -> void:
	if game_manager and game_manager.game_active:
		game_manager.deduct_time()
