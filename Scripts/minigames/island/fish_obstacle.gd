extends Area2D

@export var speed: float = 80.0
@export var move_range: Rect2 = Rect2(Vector2(300, 100), Vector2(500, 500))  # Define the movement area

var direction: Vector2

func _ready():
	randomize()
	pick_new_direction()

func _process(delta):
	position += direction * speed * delta

	# Keep the obstacle inside the defined area
	if !move_range.has_point(position):  
		pick_new_direction()

func pick_new_direction():
	# Random direction
	direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()

	# Keep the movement inside the defined area
	position.x = clamp(position.x, move_range.position.x, move_range.position.x + move_range.size.x)
	position.y = clamp(position.y, move_range.position.y, move_range.position.y + move_range.size.y)

# Collision detection
func _on_body_entered(body: Node):
	if body.is_in_group("player"):  # Check if the object colliding is the player
		body.on_hit_obstacle()  # Call the method to decrease the timer
