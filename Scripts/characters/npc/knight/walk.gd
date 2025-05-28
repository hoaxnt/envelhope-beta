extends PathFollow2D

@export var speed: float = 50.0
var direction = 1  # 1 = forward, -1 = backward
var paused = false

func _process(delta: float) -> void:
	if paused:
		return

	progress += speed * delta * direction
	await get_tree().create_timer(1.0).timeout
	print("pause watching")
	
	if progress_ratio >= 0.9 or progress_ratio <= 0.1:
		direction *= -1
		paused = true
		await get_tree().create_timer(1.0).timeout  # Pause for 1 second
		paused = false
