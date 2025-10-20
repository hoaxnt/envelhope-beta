extends Label

const SAVE_KEY = "envelopes"
const DEFAULT_ENVELOPES_VALUE = 1000

func _ready():
		var loaded_data = SaveLoad.load_game()
		var envelopes_value = loaded_data.get(SAVE_KEY, DEFAULT_ENVELOPES_VALUE)
		
		update_display(envelopes_value)

func update_display(new_value):
		text = str(new_value)
		
func save_envelopes(value_to_save):
		var save_data = SaveLoad.load_game()
		
		save_data[SAVE_KEY] = value_to_save
		SaveLoad.save_game(save_data)
		update_display(value_to_save)
