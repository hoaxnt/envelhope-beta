extends Node

@export var box_a: Rect2 = Rect2(0, 0, 100, 100)
@export var box_b: Rect2 = Rect2(50, 50, 100, 100)
@export var monitor_collision: bool = true

func _process(_delta):
	if monitor_collision:
		var colliding = check_aabb_collision(box_a, box_b)
		if colliding:
			print("Boxes are overlapping!")

func check_aabb_collision(a: Rect2, b: Rect2) -> bool:
	return a.intersects(b)
