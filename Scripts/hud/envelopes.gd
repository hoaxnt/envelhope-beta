extends Label

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
@onready var envelopes = PLAYER_DATA.get("envelopes")

func _ready():
		update_display(int(envelopes))

func update_display(new_value):
		text = str(new_value)
		
func save_envelopes(value):
		PLAYER_DATA["envelopes"] = value
		SaveLoad.save_game(PLAYER_DATA, SaveLoad.PLAYER_DATA_PATH)
		update_display(value)
		print("display updated")
