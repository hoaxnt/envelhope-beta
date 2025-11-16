extends Node2D

# --- USER CONFIGURATION ---
var START_POS = Vector2i(-1, -1)
var END_POS = Vector2i(8, 4)
# CRITICAL: A list of all Atlas Coordinates (X, Y) for ALL impassable tiles (walls, corners, etc.)
# YOU MUST ADD EVERY WALL TILE'S ATLAS COORDINATE TO THIS LIST!
const IMPASSABLE_ATLAS_COORDS = [
	Vector2i(0, 2), 
	Vector2i(1, 2), 
	# Add more Vector2i(x, y) coordinates here if you have different wall sprites!
]
# The layer index where your maze tiles are drawn (default is 0 in Godot 4+).
const LAYER_INDEX = 0

# --- NODES ---
@onready var maze_tilemap = $Maze
@onready var agent = $Agent
@onready var path_timer = $PathTimer

# --- A* VARIABLES ---
var path_to_follow = [] # The resulting shortest path (array of Vector2i)
var path_step_index = 0

# Directions for checking neighbors (Up, Down, Left, Right)
const DIRECTIONS = [
	Vector2i(0, -1),  # Up
	Vector2i(0, 1),   # Down
	Vector2i(-1, 0),  # Left
	Vector2i(1, 0)    # Right
]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the agent to the starting position on the grid
	# Cast TileMap.tile_set.tile_size (Vector2i) to Vector2 to avoid type error with map_to_local (Vector2)
	agent.position = maze_tilemap.map_to_local(START_POS) + Vector2(maze_tilemap.tile_set.tile_size) / 2

	# 1. Calculate the shortest path using A*
	path_to_follow = find_path_a_star(START_POS, END_POS)

	if path_to_follow.size() > 0:
		print("Path found! Length: ", path_to_follow.size())
		# 2. Start movement visualization
		# Updated signal connection syntax for Godot 4
		path_timer.timeout.connect(_on_path_timer_timeout)
		path_timer.wait_time = 0.25 # Time delay between steps
		path_timer.start()
	else:
		print("No path found between the start and end points!")

# --- A* IMPLEMENTATION ---

# Calculates the heuristic score (Manhattan distance) for A*
func _calculate_h_score(pos: Vector2i, target_pos: Vector2i) -> int:
	# Manhattan distance: sum of the difference in x and y coordinates (perfect for grid movement)
	return abs(target_pos.x - pos.x) + abs(target_pos.y - pos.y)

# Finds the shortest path between start_pos and end_pos using A* Search.
# Returns an Array of Vector2i grid coordinates, or an empty Array if no path exists.
func find_path_a_star(start_pos: Vector2i, end_pos: Vector2i):
	# G-Score: Cost from start to current node
	var g_score_map: Dictionary = {start_pos: 0}
	# F-Score: Total estimated cost (G + H)
	var f_score_map: Dictionary = {start_pos: _calculate_h_score(start_pos, end_pos)}
	# Parent map for path reconstruction (child_pos -> parent_pos)
	var parent_map: Dictionary = {}
	
	# Open set: list of grid positions currently being evaluated
	# This acts as a manual Priority Queue: we sort it implicitly by finding the min F-score node
	var open_set: Array[Vector2i] = [start_pos]

	# Handle non-walkable start/end
	if not _is_walkable(start_pos) or not _is_walkable(end_pos):
		print("Start or End position is not walkable.")
		return []

	while not open_set.is_empty():
		# 1. Find the node in open_set with the lowest F-score
		var current_pos = open_set[0]
		var lowest_f_score = f_score_map[current_pos]

		for pos in open_set:
			if f_score_map.get(pos, INF) < lowest_f_score:
				lowest_f_score = f_score_map[pos]
				current_pos = pos

		# 2. Remove the current node from the open set (equivalent to dequeuing)
		open_set.erase(current_pos)

		# 3. Target check
		if current_pos == end_pos:
			return _reconstruct_path(start_pos, end_pos, parent_map)

		# 4. Check all neighbors
		for direction in DIRECTIONS:
			var neighbor_pos = current_pos + direction

			if not _is_walkable(neighbor_pos):
				continue

			# Cost to reach neighbor from start through current node
			# Movement cost is 1 for cardinal directions
			var tentative_g_score = g_score_map.get(current_pos, INF) + 1 

			# Check if we've found a better path to the neighbor
			if tentative_g_score < g_score_map.get(neighbor_pos, INF):
				# Found a better path! Record it.
				parent_map[neighbor_pos] = current_pos
				g_score_map[neighbor_pos] = tentative_g_score
				f_score_map[neighbor_pos] = tentative_g_score + _calculate_h_score(neighbor_pos, end_pos)

				# If the neighbor is not already in the open set, add it for evaluation
				if not open_set.has(neighbor_pos):
					open_set.append(neighbor_pos)

	# No path found
	return []

# Checks if a given grid coordinate is a walkable tile (not a wall)
func _is_walkable(pos: Vector2i) -> bool:
	# FIX: Reinstated LAYER_INDEX and added 'false' for 'use_mesh' to satisfy the 3-argument requirement.
	var tile_coords = maze_tilemap.get_cell_atlas_coords(LAYER_INDEX, pos, false)

	# --- DEBUGGING OUTPUT START ---
	# This will print the coordinates being read by the TileMap when the A* tries to search a tile.
	# If this is a wall, the output will tell you the correct coordinate to add to the IMPASSABLE_ATLAS_COORDS list.
	if not IMPASSABLE_ATLAS_COORDS.has(tile_coords) and tile_coords != Vector2i(-1, -1):
		# Only print if it's a non-empty tile AND it's not currently in our impassable list
		print("DEBUG: Tile at ", pos, " is currently being considered walkable, but has coords: ", tile_coords)
	# --- DEBUGGING OUTPUT END ---

	# If the coordinates are (-1, -1), the cell is empty/null (walkable).
	if tile_coords == Vector2i(-1, -1):
		return true

	# Check if the tile's coordinates are in our list of impassable tiles.
	# If the list HAS the tile's coordinates, the tile is NOT walkable (returns false).
	return not IMPASSABLE_ATLAS_COORDS.has(tile_coords)

# Reconstructs the path from the end back to the start using the parent_map
func _reconstruct_path(start_pos: Vector2i, end_pos: Vector2i, parent_map: Dictionary):
	var path = []
	var current = end_pos

	# Trace back from the end to the start
	while current != start_pos:
		path.append(current)
		if parent_map.has(current):
			current = parent_map[current]
		else:
			# Error: Path reconstruction failed (should not happen if A* succeeded)
			print("Error: Path reconstruction failed.")
			return []

	# Add the start position
	path.append(start_pos)
	# Reverse the array to get the path from start to end
	path.reverse()
	return path

# --- MOVEMENT VISUALIZATION ---

# Called when the Timer times out, moving the agent one step along the path.
func _on_path_timer_timeout():
	if path_step_index < path_to_follow.size():
		var next_grid_pos = path_to_follow[path_step_index]
		
		# Convert grid coordinate to local pixel position
		var next_world_pos = maze_tilemap.map_to_local(next_grid_pos)
		
		# Move the agent smoothly to the center of the next tile
		# Cast TileMap.tile_set.tile_size (Vector2i) to Vector2
		var target_position = next_world_pos + Vector2(maze_tilemap.tile_set.tile_size) / 2

		# Use Tweening for smooth movement visualization
		var tween = create_tween()
		tween.tween_property(agent, "position", target_position, path_timer.wait_time)
		
		path_step_index += 1
	else:
		# Path complete!
		path_timer.stop()
		print("Agent reached the destination!")
