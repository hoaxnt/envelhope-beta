extends PathFollow2D

@export var speed: float = 50.0
var direction := 1
var walking := false
var pause := 2

func _ready():
	start_walking()

func start_walking():
	if not walking:
		walking = true
		_walk()  # Start the walking loop

func _walk() -> void:
	await get_tree().process_frame  # Let the scene fully load first
	while true:
		while true:
			progress += speed * get_process_delta_time() * direction
			if (direction == 1 and progress_ratio >= 0.9) or (direction == -1 and progress_ratio <= 0.1):
				break
			await get_tree().process_frame

		await get_tree().create_timer(pause).timeout  # Pause at the end
		direction *= -1  # Reverse direction
