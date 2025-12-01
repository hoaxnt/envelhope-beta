extends Node

# The function implements the AABB collision logic using Godot's built-in Rect2 type.
# Rect2 is defined by a position (Vector2) and a size (Vector2).
# It represents an Axis-Aligned Bounding Box in 2D space.
func check_aabb_collision(box_a: Rect2, box_b: Rect2) -> bool:
	# Godot's Rect2 type has a powerful built-in method called 'intersects'.
	# This method performs the exact logic of checking if the X and Y intervals
	# of both rectangles overlap.
	return box_a.intersects(box_b)

# This function runs when the node enters the scene tree.
func _ready():
	print("--- AABB Collision Test ---")

	# --- SCENARIO 1: COLLIDING BOXES ---
	
	# Box A: Starts at (0, 0), spans 100 units wide and high.
	# Coordinates: X: 0 to 100, Y: 0 to 100
	var box_a = Rect2(Vector2(0, 0), Vector2(100, 100))
	
	# Box B: Starts at (50, 50), spans 100 units wide and high.
	# Coordinates: X: 50 to 150, Y: 50 to 150
	# This box overlaps Box A from (50, 50) to (100, 100).
	var box_b = Rect2(Vector2(50, 50), Vector2(100, 100))
	
	var is_colliding_1 = check_aabb_collision(box_a, box_b)
	
	print("\n--- Test Case 1: Overlapping ---")
	print("Box A: ", box_a)
	print("Box B: ", box_b)
	print("Collision Detected: ", is_colliding_1) # Expected: True
	
	
	# --- SCENARIO 2: NON-COLLIDING BOXES ---
	
	# Box C: Starts at (101, 101), spans 100 units wide and high.
	# Coordinates: X: 101 to 201, Y: 101 to 201
	# Box A ends at X=100 and Y=100, so there is no overlap.
	var box_c = Rect2(Vector2(101, 101), Vector2(100, 100))
	
	var is_colliding_2 = check_aabb_collision(box_a, box_c)
	
	print("\n--- Test Case 2: Separated ---")
	print("Box A: ", box_a)
	print("Box C: ", box_c)
	print("Collision Detected: ", is_colliding_2) # Expected: False

	print("\n-----------------------------------")
