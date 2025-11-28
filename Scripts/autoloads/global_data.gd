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
		current_day = 0
	var next_day = current_day + 1
	npc_data["day"] = next_day
	if next_day == 4:
		npc_data["release_the_kraken"] = true
	SaveLoad.save_game(npc_data, SaveLoad.NPC_DATA_PATH)


func get_player_data_value(key: String):
	return player_data.get(key)

func save_player_position(position: Vector2):
	var pos_array = [position.x, position.y]
	player_data["position"] = pos_array
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
	player_data_updated.emit("position", pos_array)
	
func load_player_position() -> Vector2:
	var pos_array = player_data.get("position")
	if pos_array is Array and pos_array.size() == 2:
		return Vector2(pos_array[0], pos_array[1])
	else:
		return Vector2(80.0, 486.0)

func handle_hunger_reset_city():
	player_data["hunger"] = 100.0
	player_data["envelopes"] = 0
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)

func handle_hunger_reset_island():
	player_data["hunger"] = 100.0
	player_data["envelopes"] = 0
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)

func purchase_food(cost: int, hunger_gain: float):
	if player_data["envelopes"] >= cost:
		player_data["envelopes"] -= cost
		player_data["hunger"] += hunger_gain
		
		player_data["hunger"] = min(player_data["hunger"], 100.0)
		
		SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
		
		player_data_updated.emit("hunger", player_data["hunger"])
		player_data_updated.emit("envelopes", player_data["envelopes"])
		
		return true
	return false
