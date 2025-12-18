extends Node

var player_data: Dictionary = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
var npc_data: Dictionary = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
var inventory: Dictionary = SaveLoad.load_game(SaveLoad.INVENTORY_PATH)
var config: Dictionary = SaveLoad.load_game(SaveLoad.CONFIG_PATH)


signal player_data_updated(key, value)
signal npc_data_updated(attribute_key: String, new_value)
signal config_updated(key, value)
signal inventory_updated(key, value)

func update_npc_data(key: String, value):
	player_data[key] = value
	SaveLoad.save_game(npc_data, SaveLoad.NPC_DATA_PATH)
	npc_data_updated.emit(key, value)

func update_player_data(key: String, value):
	player_data[key] = value
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
	player_data_updated.emit(key, value)

func update_config_data(key: String, value):
	config[key] = value
	SaveLoad.save_game(config, SaveLoad.CONFIG_PATH)
	config_updated.emit(key, value)

func update_inventory_data(key: String, value):
	inventory[key] = value
	SaveLoad.save_game(inventory, SaveLoad.INVENTORY_PATH)
	inventory_updated.emit(key, value)

func advance_to_next_day():
	var current_day = npc_data.get("day", 1)
	if current_day >= 4:
		current_day = 1
	var next_day = current_day + 1
	npc_data["day"] = next_day

	SaveLoad.save_game(npc_data, SaveLoad.NPC_DATA_PATH)


func get_player_data_value(key: String):
	return player_data.get(key)

func save_player_position(position: Vector2):
	var pos_array = [position.x, position.y]
	player_data["position"] = pos_array
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
	player_data_updated.emit("position", pos_array)
	
func save_player1_position(position: Vector2):
	var pos_array = [position.x, position.y]
	player_data["position_1"] = pos_array
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
	player_data_updated.emit("position_1", pos_array)

func save_player2_position(position: Vector2):
	var pos_array = [position.x, position.y]
	player_data["position_2"] = pos_array
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
	player_data_updated.emit("position_2", pos_array)
	

func load_player_position() -> Vector2:
	var pos_array = player_data.get("position")
	if pos_array is Array and pos_array.size() == 2:
		return Vector2(pos_array[0], pos_array[1])
	else:
		return Vector2(80.0, 486.0)
		
func load_player1_position() -> Vector2:
	var pos_array = player_data.get("position_1")
	if pos_array is Array and pos_array.size() == 2:
		return Vector2(pos_array[0], pos_array[1])
	else:
		return Vector2(628.0, 280.0)

func load_player2_position() -> Vector2:
	var pos_array = player_data.get("position_2")
	if pos_array is Array and pos_array.size() == 2:
		return Vector2(pos_array[0], pos_array[1])
	else:
		return Vector2(143.0, 503.0)

func handle_hunger_reset_city():
	player_data["hunger"] = 100.0
	player_data["envelopes"] = 0
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)

func handle_hunger_reset_island():
	player_data["hunger"] = 100.0
	player_data["envelopes"] = 0
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)

func purchase_food(cost: int):
	if InventoryManager:
		if player_data["envelopes"] >= cost:
			player_data["envelopes"] -= cost
		
			var options = ["Banana", "Water", "Chips"]
			var item_name = options.pick_random()
			InventoryManager.add_item(item_name)
		
		return true
	return false
