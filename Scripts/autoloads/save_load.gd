extends Node

const CONFIG_PATH = "user://config.json"
const SAVE_PATH = "user://game_data.json" 

func save_game(data_to_save: Dictionary, path: String) -> Error:
		var file = FileAccess.open(path, FileAccess.WRITE)
		var json_string = JSON.stringify(data_to_save, "\t", true)
		file.store_string(json_string)
		return OK

func load_game(path: String) -> Dictionary:
		if not FileAccess.file_exists(path):
				print("No save file found at: ", path)
				return {}
		var file = FileAccess.open(path, FileAccess.READ)
		if file == null:
				printerr("Failed to load game. Error code: ", FileAccess.get_open_error())
				return {}
				
		var json_string = file.get_as_text()
		var parse_result = JSON.parse_string(json_string)
		
		if parse_result == null:
				printerr("Failed to parse JSON string.")
				return {}

		return parse_result
