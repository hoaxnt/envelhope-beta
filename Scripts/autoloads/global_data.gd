extends Node

var player_data: Dictionary = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
var npc_data: Dictionary = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)

signal player_data_updated(key, value)


func update_player_data(key: String, value):
	player_data[key] = value
	SaveLoad.save_game(player_data, SaveLoad.PLAYER_DATA_PATH)
	player_data_updated.emit(key, value)

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
