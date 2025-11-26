extends Label

@onready var PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)

func _ready() -> void:
	PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
	text = str(int(PLAYER_DATA["envelopes"]))
	
func _on_timer_timeout() -> void:
	PLAYER_DATA = SaveLoad.load_game(SaveLoad.PLAYER_DATA_PATH)
	text = str(int(PLAYER_DATA["envelopes"]))
