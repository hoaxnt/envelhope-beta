extends Node2D

var START_POS = Vector2i(-1, -1)
var END_POS = Vector2i(8, 4)

const IMPASSABLE_ATLAS_COORDS = [
	Vector2i(0, 2), 
	Vector2i(1, 2), 
]

const LAYER_INDEX = 0

@export var maze_tilemap : Sprite2D
@export var agent : Node2D
@export var path_timer : Timer

var path_to_follow = [] 
var path_step_index = 0

const DIRECTIONS = [
	Vector2i(0, -1), 
	Vector2i(0, 1),  
	Vector2i(-1, 0), 
	Vector2i(1, 0)   
]

func _ready():
	agent.position = maze_tilemap.map_to_local(START_POS) + Vector2(maze_tilemap.tile_set.tile_size) / 2

	path_to_follow = find_path_a_star(START_POS, END_POS)

	if path_to_follow.size() > 0:
		print("Path found! Length: ", path_to_follow.size())
		path_timer.timeout.connect(_on_path_timer_timeout)
		path_timer.wait_time = 0.25 
		path_timer.start()
	else:
		print("No path found between the start and end points!")

func _calculate_h_score(pos: Vector2i, target_pos: Vector2i) -> int:
	return abs(target_pos.x - pos.x) + abs(target_pos.y - pos.y)

func find_path_a_star(start_pos: Vector2i, end_pos: Vector2i):
	var g_score_map: Dictionary = {start_pos: 0}
	var f_score_map: Dictionary = {start_pos: _calculate_h_score(start_pos, end_pos)}
	var parent_map: Dictionary = {}
	
	var open_set: Array[Vector2i] = [start_pos]

	if not _is_walkable(start_pos) or not _is_walkable(end_pos):
		print("Start or End position is not walkable.")
		return []

	while not open_set.is_empty():
		var current_pos = open_set[0]
		var lowest_f_score = f_score_map[current_pos]

		for pos in open_set:
			if f_score_map.get(pos, INF) < lowest_f_score:
				lowest_f_score = f_score_map[pos]
				current_pos = pos

		open_set.erase(current_pos)

		if current_pos == end_pos:
			return _reconstruct_path(start_pos, end_pos, parent_map)

		for direction in DIRECTIONS:
			var neighbor_pos = current_pos + direction

			if not _is_walkable(neighbor_pos):
				continue

			var tentative_g_score = g_score_map.get(current_pos, INF) + 1 

			if tentative_g_score < g_score_map.get(neighbor_pos, INF):
				parent_map[neighbor_pos] = current_pos
				g_score_map[neighbor_pos] = tentative_g_score
				f_score_map[neighbor_pos] = tentative_g_score + _calculate_h_score(neighbor_pos, end_pos)

				if not open_set.has(neighbor_pos):
					open_set.append(neighbor_pos)

	return []

func _is_walkable(pos: Vector2i) -> bool:
	var tile_coords = maze_tilemap.get_cell_atlas_coords(LAYER_INDEX, pos, false)

	if not IMPASSABLE_ATLAS_COORDS.has(tile_coords) and tile_coords != Vector2i(-1, -1):
		print("DEBUG: Tile at ", pos, " is currently being considered walkable, but has coords: ", tile_coords)

	if tile_coords == Vector2i(-1, -1):
		return true

	return not IMPASSABLE_ATLAS_COORDS.has(tile_coords)

func _reconstruct_path(start_pos: Vector2i, end_pos: Vector2i, parent_map: Dictionary):
	var path = []
	var current = end_pos

	while current != start_pos:
		path.append(current)
		if parent_map.has(current):
			current = parent_map[current]
		else:
			print("Error: Path reconstruction failed.")
			return []

	path.append(start_pos)
	path.reverse()
	return path

func _on_path_timer_timeout():
	if path_step_index < path_to_follow.size():
		var next_grid_pos = path_to_follow[path_step_index]
		var next_world_pos = maze_tilemap.map_to_local(next_grid_pos)
		var target_position = next_world_pos + Vector2(maze_tilemap.tile_set.tile_size) / 2

		var tween = create_tween()
		tween.tween_property(agent, "position", target_position, path_timer.wait_time)
		
		path_step_index += 1
	else:
		path_timer.stop()
		#print("Agent reached the destination!")
