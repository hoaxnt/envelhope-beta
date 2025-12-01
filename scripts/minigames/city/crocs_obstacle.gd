extends Area2D

@export var speed: float = 200.0
@export var move_range: Rect2 = Rect2(Vector2(300, 100), Vector2(500, 500))
var direction: Vector2

func _ready() -> void:
	pick_new_direction()

func _process(delta):
	if get_parent().game_started:
		position += direction * speed * delta
		if !move_range.has_point(position):
			pick_new_direction()

func pick_new_direction():
	direction = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized()

	position.x = clamp(position.x, move_range.position.x, move_range.position.x + move_range.size.x)
	position.y = clamp(position.y, move_range.position.y, move_range.position.y + move_range.size.y)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.on_hit_obstacle()
