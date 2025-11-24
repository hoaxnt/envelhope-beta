extends Node2D
#
## --- Configuration ---
#const TILE_SIZE: int = 64 # Must match the TileMap's cell size
#const WALL_TILE_ID: int = 1 # The ID of your wall tile in the TileSet
#const START_TILE_ID: int = 2 # An arbitrary ID for drawing the start point
#const END_TILE_ID: int = 3   # An arbitrary ID for drawing the end point
#const PATH_TILE_ID: int = 4  # An arbitrary ID for drawing the path
#
## --- Game State ---
#var astar_grid: AStarGrid2D = AStarGrid2D.new()
#var start_point: Vector2i = Vector2i.ZERO # Stores the coordinates of the start point
#var end_point: Vector2i = Vector2i.ZERO   # Stores the coordinates of the end point
#var path_found: PackedVector2Array = []   # The final list of points to follow
#
#@onready var map: TileMap = $Map
#@onready var status_label: Label = $CanvasLayer/StatusLabel
#var is_setting_start: bool = true # State machine for clicks
#
## --- Setup: Start to End ---
#
#func _ready() -> void:
		## 1. Initialize AStarGrid2D
		#
		## AStarGrid2D works best with an initial rectangular area.
		## We will grab the entire used area of the TileMap.
		#var map_rect: Rect2i = map.get_used_rect()
		#
		## Set the size of the AStar grid based on the TileMap dimensions
		#astar_grid.size = map_rect.size
		#
		## Set the offset so grid coordinates match tile coordinates
		#astar_grid.offset = Vector2(map_rect.position)
		#
		## Set the default cell size (used for distance calculation)
		#astar_grid.cell_size = Vector2(TILE_SIZE, TILE_SIZE)
#
		## Set the default mode to 4-way movement (up, down, left, right)
		#astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
		#astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
		#
		## 2. Populate AStar Grid with Obstacles
		#_update_astar_grid_from_map()
		#
		## 3. Set initial state
		#_reset_path_visuals()
		#update_status("Click to set the **Start** point.")
#
#
## --- Input Handling (Setting Points and Walls) ---
#
#func _input(event: InputEvent) -> void:
		#if event is InputEventMouseButton and event.pressed:
				#var world_pos: Vector2 = event.position
				## Convert world coordinates to grid coordinates (Vector2i)
				#var tile_coords: Vector2i = map.local_to_map(world_pos)
				#
				## Check if the click is within the used map area
				#if not map.get_used_rect().has_point(tile_coords):
						#return
#
				## Handle placing/removing walls using Right-Click
				#if event.button_index == MOUSE_BUTTON_RIGHT:
						#_toggle_wall(tile_coords)
						#return
#
				## Ensure the selected point is not a wall
				#if astar_grid.is_in_solid(tile_coords):
						#update_status("Cannot place point on a wall!", "error")
						#return
#
				## Handle Start/End point selection using Left-Click
				#if is_setting_start:
						#_set_start_point(tile_coords)
				#else:
						#_set_end_point(tile_coords)
#
#
## --- Core Pathfinding Logic ---
#
#func _update_astar_grid_from_map() -> void:
		## Initialize all cells as non-solid first
		#astar_grid.update() 
		#
		## Get all cells in the TileMap that have a tile placed
		#var used_cells: Array[Vector2i] = map.get_used_cells(0) # Assuming layer 0
		#
		#for coord in used_cells:
			## This is the correct, simpler check:
			#if map.get_cell_tile_id(0, coord) == WALL_TILE_ID:
				## Mark this point as impassable (solid) in the AStar grid
				#astar_grid.set_point_solid(coord, true)
						#
		#print("AStar Grid updated. Solids calculated.")
		## 
#
#
#func _set_start_point(coords: Vector2i) -> void:
		#_reset_path_visuals()
		#start_point = coords
		#map.set_cell(0, start_point, START_TILE_ID)
		#is_setting_start = false
		#update_status("Start (S) set. Click to set the **End (E)** point.")
#
#
#func _set_end_point(coords: Vector2i) -> void:
		#end_point = coords
		#map.set_cell(0, end_point, END_TILE_ID)
		#is_setting_start = true # Reset state for the next run
		#
		## Calculate the final path!
		#_calculate_path()
#
#
#func _calculate_path() -> void:
		#
		## Check if the start and end points are valid and reachable
		#if not astar_grid.is_in_solid(start_point) and not astar_grid.is_in_solid(end_point):
				## get_id_path returns an array of Vector2i grid coordinates
				#path_found = astar_grid.get_id_path(start_point, end_point)
		#else:
				#path_found.clear()
				#
		#if path_found.size() > 0:
				#_draw_path()
				#update_status("Path Found! Length: %d tiles." % path_found.size(), "success")
		#else:
				#update_status("No Path Found. Check for walls or unreachability.", "error")
				#_reset_path_visuals()
#
#
## --- Visualization ---
#
#func _draw_path() -> void:
#
		## path_found[0] is start_point, path_found.back() is end_point.
		## We only draw the intermediate tiles.
		#for i in range(1, path_found.size() - 1):
				#var coord: Vector2i = path_found[i]
				## Use a specific tile ID for the path visualization
				#map.set_cell(0, coord, PATH_TILE_ID)
				#
		## Re-draw Start and End points on top
		#map.set_cell(0, start_point, START_TILE_ID)
		#map.set_cell(0, end_point, END_TILE_ID)
#
#
#func _reset_path_visuals() -> void:
	#
		#var cells_to_clear: Array[Vector2i] = map.get_used_cells(0)
		#for coord in cells_to_clear:
				#var tile_id = map.get_cell_tile_id(0, coord)
				#if tile_id in [START_TILE_ID, END_TILE_ID, PATH_TILE_ID]:
						#map.erase_cell(0, coord)
						#
		## Reset pathfinding state
		#start_point = Vector2i.ZERO
		#end_point = Vector2i.ZERO
		#path_found.clear()
		#is_setting_start = true
#
#
#func _toggle_wall(coords: Vector2i) -> void:
		#var current_id = map.get_cell_tile_id(0, coords)
		#
		#if current_id != WALL_TILE_ID:
				## Place wall
				#map.set_cell(0, coords, WALL_TILE_ID)
				#astar_grid.set_point_solid(coords, true)
		#else:
				## Remove wall
				#map.erase_cell(0, coords)
				#astar_grid.set_point_solid(coords, false)
				#
		## Recalculate if a path was already set
		#if path_found.size() > 0:
				#_reset_path_visuals()
				#update_status("Wall toggled. Restarting path selection.")
#
#
## --- Utility ---
#
#func update_status(message: String, type: String = "info") -> void:
		#status_label.text = message
		## Add simple color feedback to the label for clarity
		#match type:
				#"error":
						#status_label.set("theme_override_colors/font_color", Color.RED)
				#"success":
						#status_label.set("theme_override_colors/font_color", Color.GREEN)
				#"info":
						#status_label.set("theme_override_colors/font_color", Color.BLUE)
