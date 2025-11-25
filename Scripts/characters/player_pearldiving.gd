extends CharacterBody2D


const SPEED = 300.0  # Maximum speed the character can reach
const ACCELERATION = 20.0 # Controls how quickly the character accelerates/decelerates

func _physics_process(delta: float) -> void:
	# --- 1. Get Input Direction (4-Axis) ---
	# Get the horizontal input (A/D or ui_left/ui_right)
	var input_x := Input.get_axis("ui_left", "ui_right")
	# Get the vertical input (W/S or ui_up/ui_down)
	var input_y := Input.get_axis("ui_up", "ui_down")
	
	# Create the target direction vector
	var input_vector := Vector2(input_x, input_y).normalized()
	
	# --- 2. Calculate the Target Velocity ---
	# The velocity we *want* to reach
	var target_velocity := input_vector * SPEED
	
	velocity.x = lerp(velocity.x, target_velocity.x, ACCELERATION * delta)
	velocity.y = lerp(velocity.y, target_velocity.y, ACCELERATION * delta)
	
	# --- 4. Move and Slide ---
	move_and_slide()
