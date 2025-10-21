extends Node2D

# --- Game Configuration ---
const TILE_SIZE: int = 32  # Must match your TileMap cell size
const MOVEMENT_SPEED: float = 150.0  # Diver's speed in pixels/sec
const OXYGEN_DRAIN_RATE: float = 1.0  # Oxygen consumed per second
const MOVEMENT_OXYGEN_COST: float = 0.05 # Extra cost per tile step
const OBSTACLE_LAYER: int = 1 # The TileMap layer index containing impassable tiles

# --- Game State Variables ---
var diver: CharacterBody2D
var tilemap: TileMap
var pearls: Array[Node2D] = []
var grid: Array[Array] = []
var current_oxygen: float = 100.0
var max_oxygen: float = 100.0
var path_to_follow: Array[Vector2] = []
var is_game_over: bool = false
var pearls_collected: int = 0
var total_pearls: int = 5 # Should match number of Pearl instances in scene

# --- A* Node Class (Internal for Pathfinding) ---
class AStarNode:
	var x: int
	var y: int
	var g_cost: float = INF # Cost from start to this node
	var h_cost: float = 0.0 # Heuristic cost to end node
	var f_cost: float = INF # Total cost (g + h)
	var is_wall: bool = false
	var parent: AStarNode = null

	func _init(px: int, py: int, is_obstacle: bool):
		x = px
		y = py
		is_wall = is_obstacle

	# Manhattan Distance Heuristic (fast for grid movement)
	func calculate_h(end_node: AStarNode):
		h_cost = abs(x - end_node.x) + abs(y - end_node.y)

# --- Godot Lifecycle Functions ---

func _ready():
	# Get references to necessary nodes
	diver = $"Diver"
	tilemap = $"Tilemap"
	
	# Find all pearl nodes (assuming they are children of Main or an Item container)
	for child in get_children():
		if child is Node2D and child.name.contains("Pearl"):
			pearls.append(child)
	
	total_pearls = pearls.size()

	# Initialize the grid for A* based on the TileMap
	_initialize_grid()
	
	# Start game loop
	_update_ui()
	print("Game initialized. Total Pearls: %d. Click on the map to move the diver." % total_pearls)

# Handle user input (click/tap)
func _input(event):
	if is_game_over:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var target_pos: Vector2 = event.position
		_request_path(target_pos)
		# Consume a tiny bit of oxygen for initiating the movement
		current_oxygen -= 0.1
		_update_ui()

# Game logic update loop
func _process(delta):
	if is_game_over:
		return

	# 1. Oxygen Drain
	current_oxygen -= OXYGEN_DRAIN_RATE * delta
	if current_oxygen <= 0:
		current_oxygen = 0
		_game_over(false) # Game Over: Oxygen Depleted
		return
	
	# 2. Diver Movement
	if not path_to_follow.is_empty():
		_move_diver_along_path(delta)

	# 3. Check for Win/Lose conditions during movement
	_update_ui()

# --- Grid and Initialization Functions ---

# Convert world position to grid coordinates (Vector2i)
func _to_grid_coords(world_pos: Vector2) -> Vector2i:
	return tilemap.local_to_map(world_pos)

# Convert grid coordinates to world center position (Vector2)
func _to_world_center(grid_coords: Vector2i) -> Vector2:
	return tilemap.map_to_local(grid_coords) + Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)

# Build the grid based on TileMap obstacle layer
func _initialize_grid():
	var map_rect: Rect2i = tilemap.get_used_rect()
	var size_x = map_rect.size.x
	var size_y = map_rect.size.y
	
	grid.resize(size_x)
	for x in range(size_x):
		grid[x] = []
		grid[x].resize(size_y)
		for y in range(size_y):
			# Get the tile data from the obstacle layer
			var tile_data = tilemap.get_cell_tile_data(OBSTACLE_LAYER, Vector2i(x, y))
			var is_wall = false
			if tile_data != null:
				is_wall = true
				
			grid[x][y] = AStarNode.new(x, y, is_wall)

# --- Diver Movement and Collision ---

func _request_path(target_pos: Vector2):
	var start_coords: Vector2i = _to_grid_coords(diver.global_position)
	var end_coords: Vector2i = _to_grid_coords(target_pos)
	
	# Clamp end coordinates to valid grid size
	end_coords.x = clamp(end_coords.x, 0, grid.size() - 1)
	end_coords.y = clamp(end_coords.y, 0, grid[0].size() - 1)
	
	var start_node = grid[start_coords.x][start_coords.y]
	var end_node = grid[end_coords.x][end_coords.y]

	if end_node.is_wall:
		print("Cannot path to an obstacle!")
		path_to_follow = [] # Clear path
		return

	path_to_follow = _a_star_search(start_node, end_node)
	if path_to_follow.is_empty():
		print("No path found!")
	else:
		# Remove the starting position from the path, as the diver is already there
		path_to_follow.remove_at(0)
		print("Path found! Steps: %d" % path_to_follow.size())

func _move_diver_along_path(delta):
	var target_world_pos: Vector2 = path_to_follow[0]
	var direction: Vector2 = (target_world_pos - diver.global_position).normalized()
	var distance: float = diver.global_position.distance_to(target_world_pos)
	
	# Determine movement vector for this frame
	var move_vector: Vector2
	if distance > MOVEMENT_SPEED * delta:
		move_vector = direction * MOVEMENT_SPEED
		# Apply extra oxygen cost for moving
		current_oxygen -= MOVEMENT_OXYGEN_COST * delta
	else:
		# If close enough, snap to the target and move to the next point in the path
		diver.global_position = target_world_pos
		path_to_follow.remove_at(0)
		move_vector = Vector2.ZERO # Stop movement for this frame after snapping

		# Check for pearls at the current tile after snapping
		_check_for_pearls()

		# Check if path is complete after removing the last point
		if path_to_follow.is_empty():
			print("Destination reached.")
			return

	# Apply movement to the CharacterBody2D
	diver.move_and_slide_with_snap(move_vector * delta, Vector2.ZERO)

func _check_for_pearls():
	var diver_coords = _to_grid_coords(diver.global_position)
	
	for pearl_node in pearls:
		if is_instance_valid(pearl_node):
			var pearl_coords = _to_grid_coords(pearl_node.global_position)
			
			if diver_coords == pearl_coords:
				pearls_collected += 1
				print("Pearl collected! Count: %d" % pearls_collected)
				pearl_node.queue_free() # Remove the pearl from the scene
				pearls.erase(pearl_node) # Remove from the array
				_update_ui()
				
				if pearls_collected == total_pearls:
					_game_over(true) # Win condition
					return
				
				break # Exit loop once a pearl is found and removed

# --- A* Pathfinding Implementation ---

func _a_star_search(start_node: AStarNode, end_node: AStarNode) -> Array[Vector2]:
	# Reset state of all nodes
	for col in grid:
		for node in col:
			node.g_cost = INF
			node.f_cost = INF
			node.parent = null

	var open_set: Array[AStarNode] = [start_node]
	var closed_set: Dictionary = {}
	
	start_node.g_cost = 0.0
	start_node.calculate_h(end_node)
	start_node.f_cost = start_node.g_cost + start_node.h_cost

	while not open_set.is_empty():
		# Find node with the lowest F cost in the open set
		var current_node: AStarNode = open_set[0]
		var lowest_f = current_node.f_cost
		var lowest_index = 0
		
		for i in range(1, open_set.size()):
			if open_set[i].f_cost < lowest_f:
				lowest_f = open_set[i].f_cost
				current_node = open_set[i]
				lowest_index = i
		
		open_set.remove_at(lowest_index)
		closed_set[Vector2i(current_node.x, current_node.y)] = true

		if current_node == end_node:
			return _retrace_path(start_node, end_node)

		for neighbor in _get_neighbors(current_node):
			if neighbor.is_wall or closed_set.has(Vector2i(neighbor.x, neighbor.y)):
				continue

			# Cost to move from current to neighbor is 1 (Manhattan)
			var new_g_cost: float = current_node.g_cost + 1.0
			
			if new_g_cost < neighbor.g_cost:
				# Found a better path
				neighbor.g_cost = new_g_cost
				neighbor.parent = current_node
				neighbor.calculate_h(end_node)
				neighbor.f_cost = neighbor.g_cost + neighbor.h_cost

				if not open_set.has(neighbor):
					open_set.append(neighbor)

	return [] # Path not found

# Get all 8 neighbors (including diagonals for smoother movement, though Manhattan distance is used)
func _get_neighbors(node: AStarNode) -> Array[AStarNode]:
	var neighbors: Array[AStarNode] = []
	for x in range(-1, 2):
		for y in range(-1, 2):
			if x == 0 and y == 0:
				continue # Skip self

			var check_x = node.x + x
			var check_y = node.y + y

			# Check bounds
			if check_x >= 0 and check_x < grid.size() and check_y >= 0 and check_y < grid[0].size():
				neighbors.append(grid[check_x][check_y])
				
	return neighbors

# Reconstruct the path from end to start using parent pointers
func _retrace_path(start_node: AStarNode, end_node: AStarNode) -> Array[Vector2]:
	var path_nodes: Array[AStarNode] = []
	var current: AStarNode = end_node
	
	while current != start_node:
		path_nodes.append(current)
		if current.parent == null:
			# Should not happen if path found, but safety check
			return []
		current = current.parent

	path_nodes.append(start_node)
	path_nodes.reverse()

	# Convert node coordinates to world positions
	var world_path: Array[Vector2] = []
	for node in path_nodes:
		world_path.append(_to_world_center(Vector2i(node.x, node.y)))

	return world_path

# --- UI and Game Over ---

func _update_ui():
	# In a real Godot game, this would update your Label and TextureRect nodes.
	var oxygen_percent = round(current_oxygen * 100) / 100.0
	# Example pseudo-UI update for console:
	# $CanvasLayer/OxygenBar.value = oxygen_percent
	# $CanvasLayer/PearlCount.text = "%d / %d" % [pearls_collected, total_pearls]
	
	# For demonstration:
	# print("Oxygen: %s%% | Pearls: %d/%d" % [oxygen_percent, pearls_collected, total_pearls])
	pass


func _game_over(has_won: bool):
	is_game_over = true
	path_to_follow = [] # Stop diver movement
	
	if has_won:
		print("--- YOU WIN! --- All pearls collected!")
		# Display Win screen
	else:
		print("--- GAME OVER! --- Oxygen depleted.")
		# Display Lose screen
	
	# In a real game, you would display a modal or a UI screen here.

# You can connect a button's 'pressed' signal to this function to reset the game
func restart_game():
	get_tree().reload_current_scene()
