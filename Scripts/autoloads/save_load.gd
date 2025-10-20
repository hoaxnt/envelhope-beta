extends Node

const SAVE_PATH = "user://game_data.json" 

func save_game(data_to_save: Dictionary) -> Error:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		
		#if file == null:
				#var error = FileAccess.get_open_error()
				#printerr("Failed to save game. Error code: ", error)
				#return error
		
		var json_string = JSON.stringify(data_to_save, "\t", true)
		file.store_string(json_string)
		return OK

func load_game() -> Dictionary:
		if not FileAccess.file_exists(SAVE_PATH):
				print("No save file found at: ", SAVE_PATH)
				return {}
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file == null:
				printerr("Failed to load game. Error code: ", FileAccess.get_open_error())
				return {}
				
		var json_string = file.get_as_text()
		var parse_result = JSON.parse_string(json_string)
		
		if parse_result == null:
				printerr("Failed to parse JSON string.")
				return {}

		return parse_result
